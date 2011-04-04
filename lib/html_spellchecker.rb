# Encoding: UTF-8

require "hunspell-ffi"
require "nokogiri"
require "set"


class HTML_Spellchecker
  def self.english
    @english ||= self.new("/usr/share/hunspell/en_US.aff", "/usr/share/hunspell/en_US.dic")
  end

  def self.french
    @french ||= self.new("/usr/share/hunspell/fr_FR.aff", "/usr/share/hunspell/fr_FR.dic")
  end

  def initialize(aff, dic)
    @dict = Hunspell.new(aff, dic)
  end

  def spellcheck(html)
    Nokogiri::HTML::DocumentFragment.parse(html).spellcheck(@dict)
  end

  class <<self
    attr_accessor :spellcheckable_tags
  end
  self.spellcheckable_tags = Set.new(%w(p ol ul li div header article nav section footer aside dd dt dl
                                        span blockquote cite q mark ins del table td th tr tbody thead tfoot
                                        a b i s em small strong hgroup h1 h2 h3 h4 h5 h6))
end

class Nokogiri::HTML::DocumentFragment
  def spellcheckable?
    true
  end
end

class Nokogiri::XML::Node
  def spellcheck(dict)
    if spellcheckable?
      inner = children.map {|child| child.spellcheck(dict) }.join
      children.remove
      add_child Nokogiri::HTML::DocumentFragment.parse(inner)
    end
    to_html(:indent => 0)
  end

  def spellcheckable?
    HTML_Spellchecker.spellcheckable_tags.include? name
  end
end

class Nokogiri::XML::Text
  WORDS_REGEXP = RUBY_VERSION =~ /^1\.8/ ? /(&\w+;)|([\w']+)/ : /(&\p{Word}{2,3};)|([\p{Word}']+)/
  ENTITIES = ["&gt;", "&lt;", "&amp;"]

  def spellcheck(dict)
    to_xhtml(:encoding => 'UTF-8').gsub(WORDS_REGEXP) do |word|
      if ENTITIES.include?(word) || dict.check(word)
        word
      else
        "<span class=\"misspelled\">#{word}</span>"
      end
    end
  end
end
