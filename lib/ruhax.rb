require 'parser/current'
require './parsers/master'
require './parsers/base_type'
require './parsers/call'
require './parsers/function'
require './parsers/args'
require './parsers/var'
require './parsers/class'

node = Parser::CurrentRuby.parse("
  class Main
    def self.main()
      my_name = 'hello world'
      puts my_name
    end
  end
")

p node

parser = Ruhax::MasterParser.new
puts parser.parse_new_node(node).to_s
