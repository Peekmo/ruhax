require 'parser/current'
require './parsers/master'
require './parsers/base_type'
require './parsers/call'
require './parsers/function'
require './parsers/args'

node = Parser::CurrentRuby.parse("
  def self.main()
    puts 'hello world'
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
