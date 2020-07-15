require 'yaml'
require 'pp'

d = YAML.load_file('database.yml')
pp d
