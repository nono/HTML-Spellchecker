# encoding: UTF-8
path = File.expand_path(File.dirname(__FILE__) + "/../lib/")
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
require "html_spellchecker"


describe HTML_Spellchecker do
  let(:checker) { HTML_Spellchecker.english }

  it "doesn't modify correct sentences" do
    correct = "<p>This is a sentence with correct words.</p>"
    checker.spellcheck(correct).should == correct
  end

  it "marks spelling errors" do
    incorrect = "<p>xzqwy is not a word!</p>"
    checker.spellcheck(incorrect) == "<p><mark class=\"misspelled\">xzqwy</span> is not a word!</p>"
  end

  it "doesn't try to spellcheck code tags" do
    txt = "<code>class Foo\ndef hello\nputs 'Hi'\nend\nend</code>"
    checker.spellcheck(txt).should == txt
  end

  it "can use different dictionnaries" do
    french_text = "<p>Ceci est un texte correct, mais xzqwy n'est pas un mot</p>"
    expected = french_text.gsub('xzqwy', '<mark class="misspelled">xzqwy</mark>')
    HTML_Spellchecker.french.spellcheck(french_text).should == expected
  end

  it "can spellcheck nested tags" do
    txt = "<p>This is <strong>Important and <em>xzqwy</em></strong>!</p>"
    checker.spellcheck(txt).should == txt.gsub('xzqwy', '<mark class="misspelled">xzqwy</mark>')
  end
end