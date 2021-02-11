require File.join(File.dirname(__FILE__), 'lib/inprovise/version')

Gem::Specification.new do |gem|
  gem.authors       = ["Martin Corino"]
  gem.email         = ["mcorino@remedy.nl"]
  gem.description   = %q{InProvisE is Intuitive Provisioning Environment}
  gem.summary       = %q{Simple, easy and intuitive infrastructure provisioning}
  gem.homepage      = "https://github.com/mcorino/Inprovise"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "inprovise"
  gem.require_paths = ["lib"]
  gem.version       = Inprovise::VERSION
  gem.add_dependency('colored', '~> 1.2')
  gem.add_dependency('net-ssh', '>= 5', '< 7')
  gem.add_dependency('net-sftp', '~> 2.1')
  gem.add_dependency('gli', '~> 2.14')
  gem.add_dependency('tilt', '~> 2.0')
  gem.post_install_message = ''
end
