# encoding: utf-8

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'eac_rails_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'eac_rails_utils'
  s.version     = EacRailsUtils::VERSION
  s.authors     = ['E.A.C.']
  s.summary     = 'Código reutilizável para as aplicações Rails da E.A.C..'

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'htmlbeautifier', '>= 1.1.1'
  s.add_dependency 'bootstrap-sass', '>= 3.3.6'
  s.add_dependency 'ofx-parser', '>= 1.1.0'
  s.add_dependency 'virtus', '>= 1.0.5'

  # Formulários aninhados
  # https://github.com/ncri/nested_form_fields
  s.add_dependency 'nested_form_fields'

  s.add_development_dependency 'sqlite3'
end
