require 'parser/current'
require './parsers/master'
require './parsers/string'
require './parsers/statement'

node = Parser::CurrentRuby.parse("
  puts 'Hello World'
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

parser = Ruhax::MasterParser.new
puts parser.parse_new_node node
