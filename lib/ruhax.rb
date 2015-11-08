require 'parser/current'
require './parsers/master'
require './parsers/base_type'
require './parsers/call'
require './parsers/function'
require './parsers/args'
require './parsers/var'

node = Parser::CurrentRuby.parse("
  def self.main()
    my_name = 'hello world'
    @x = 5
    puts my_name
  end
")

p node

print <<eos
 class Main {
eos

parser = Ruhax::MasterParser.new
puts parser.parse_new_node(node).to_s

print <<eos
}
eos
