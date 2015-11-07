require 'parser/current'
require './parsers/master'
require './parsers/base_type'
require './parsers/statement'
require './parsers/function'
require './parsers/args'

node = Parser::CurrentRuby.parse("
  def main
    puts 'Hello world'
  end

  main
")

p node

print <<eos
 class Main {
eos

parser = Ruhax::MasterParser.new
puts parser.parse_new_node node

print <<eos
}
eos
