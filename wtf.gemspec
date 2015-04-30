$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'wordtranslationfast_info'

Gem::Specification.new do |s|
  s.name        = 'wtf'
  s.version     = WordTranslationFast::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Isaiah Goertz']
  s.email       = ['isaiahmg@gmail.com']
  s.homepage    = 'http://isaiah.work'
  
  s.summary     = WordTranslationFast::SUMMARY
  s.description = WordTranslationFast::DESCRIPTION
  s.license     = 'MIT License (MIT)'
  
  s.files       = FileList[
                    'bin/wtf',
                    'man/wordtranslationfast.1',
                    'lib/*',
                    'LICENSE']
  s.executables = ['wtf']
  s.add_dependency('json', '~> 1.8')
end