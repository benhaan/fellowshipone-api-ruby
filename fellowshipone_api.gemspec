Gem::Specification.new do |s|
  PROJECT_GEM = 'fellowshipone-api'
  PROJECT_GEM_VERSION = '0.9.0'
  
  s.name = PROJECT_GEM
  s.version = PROJECT_GEM_VERSION
  s.platform = Gem::Platform::RUBY

  s.homepage = 'https://github.com/weshays/fellowshipone-api-ruby'
  s.rubyforge_project = 'Project on www.github.com'
  s.authors = ['Wes Hays', 'Chad Feller', 'Taylor Brooks']
  s.email = ['weshays@gbdev.com','feller@cs.unr.edu']

  s.summary = 'Ruby gem/plugin to interact with the FellowshipOne API (https://developer.fellowshipone.com/).'
  s.description = 'Ruby gem/plugin to interact with the FellowshipOne API (https://developer.fellowshipone.com/). Checkout the project on github for more detail.'

  s.add_dependency('typhoeus', '0.7.1')
  s.add_dependency('oauth_weshays', '0.4.8.pre2')


  s.files         = `git ls-files`.split("\n").delete_if { |f| !(f =~ /^examples/).nil? }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
