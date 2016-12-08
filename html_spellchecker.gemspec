Gem::Specification.new do |s|
  s.name             = "html_spellchecker"
  s.version          = "0.1.8"
  s.date             = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage         = "http://github.com/nono/HTML-Spellchecker"
  s.authors          = "Bruno Michel"
  s.email            = "bmichel@menfin.info"
  s.description      = "Wants to spellcheck an HTML string properly? This gem is for you."
  s.summary          = "Wants to spellcheck an HTML string properly? This gem is for you."
  s.extra_rdoc_files = %w(README.md)
  s.files            = Dir["MIT-LICENSE", "README.md", "Gemfile", "lib/**/*.rb"]
  s.require_paths    = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.add_dependency "nokogiri", "~>1.4"
  s.add_dependency "ffi-hunspell", "=0.3.1"
  s.add_development_dependency "rspec", "~>2.4"
end
