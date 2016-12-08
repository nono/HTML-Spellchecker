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
    checker.spellcheck(incorrect) == "<p><span class=\"misspelled\">xzqwy</span> is not a word!</p>"
  end

  it "doesn't try to spellcheck code tags" do
    txt = "<code>class Foo\ndef hello\nputs 'Hi'\nend\nend</code>"
    checker.spellcheck(txt).should == txt
  end

  it "can use different dictionnaries" do
    french_text = "<p>Ceci est un texte correct, mais xzqwy n'est pas un mot</p>"
    expected = french_text.gsub('xzqwy', '<span class="misspelled">xzqwy</span>')
    HTML_Spellchecker.french.spellcheck(french_text).should == expected
  end

  it "can spellcheck nested tags" do
    txt = "<p>This is <strong>Important and <em>xzqwy</em></strong>!</p>"
    checker.spellcheck(txt).should == txt.gsub('xzqwy', '<span class="misspelled">xzqwy</span>')
  end

  it "does not mangle spaces between 2 incorrect words" do
    txt = "<p>xxx yyy zzz</p>"
    expected = "<p>xxx yyy zzz</p>".gsub(/(\w{3})/, '<span class="misspelled">\1</span>')
    checker.spellcheck(txt).should == expected
  end

  it "keeps <, > and & untouched" do
    txt = "<p>Inferior: &lt;</p><p>Superior: &gt;</p><p>Ampersand: &amp;</p>"
    checker.spellcheck(txt).should == txt
  end

  it "preserves accents" do
    txt = "<p>café caf&eacute;</p>"
    HTML_Spellchecker.french.spellcheck(txt).should_not =~ /misspelled/
  end

  it "does not split words with a quote" do
    txt = "<p>It doesn't matter</p>"
    checker.spellcheck(txt).should == txt
  end
end
