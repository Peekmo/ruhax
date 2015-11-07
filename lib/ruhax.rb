require 'parser/current'
require './parsers/master'
require './parsers/base_type'
require './parsers/statement'

node = Parser::CurrentRuby.parse("
    puts 'Hello world'
    puts 'test'
")

p node
puts "***********************"
p node.type
p node.children
puts "***********************"
node.children.each do |c|
  if c.is_a? AST::Node
    p c.type
    p c.children
  end
end

print <<eos
 class Main {
   public static function main() {
eos

parser = Ruhax::MasterParser.new
puts parser.parse_new_node node

print <<eos
  }
}
eos
