HTML Spellchecker
=================

Wants to spellcheck an HTML string properly? This gem is for you.
It's powered by [Nokogiri](http://nokogiri.org/) and
[ffi-hunspell](https://github.com/postmodern/ffi-hunspell)!


How to use it
-------------

It's very simple. Install it with rubygems:
```sh
gem install html_spellchecker
```
Or, if you use bundler, add it to your `Gemfile`:
```sh
gem "html_spellchecker", :version => "~>0.1"
```
Then you can use it in your code:
```rb
require "html_spellchecker"
HTML_Spellchecker.english.spellcheck("<p>This is xzqwy.</p>")
# => "<p>This is <mark class="misspelled">xzqwy</mark>.</p>"
```
The HTML_Spellchecker class can be initialized by giving 2 paths:
the affinity and dictionnary for hunspell. There are helpers to
create a new instance for english and french dictionnaries.

Then, you can use `spellcheck` method: you give it an HTML string
and it returns you with the same string with misspelled words
enclosed in `<mark>` tags (with the `misspelled` class).

HTML_Spellchecker can avoid to check the spelling of special tags
like `<code>`, by keeping a list of the tags to spellcheck in
`HTML_Spellchecker.spellcheckable_tags`.


Issues or Suggestions
---------------------

Found an issue or have a suggestion? Please report it on
[Github's issue tracker](http://github.com/nono/HTML-Spellchecker/issues).

If you wants to make a pull request, please check the specs before:
```sh
rspec spec
```

Credits
-------

Thanks [Andreas Haller](https://github.com/ahaller) for the hunspell-ffi gem.

Copyright (c) 2011 Bruno Michel <bmichel@menfin.info>, released under the MIT license
