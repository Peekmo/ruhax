require 'parser/current'

node = Parser::CurrentRuby.parse("
  puts 'Hello World'
")

p node
puts "***********************"
p node.type
p node.children
puts "***********************"
node.children.each do |c|
  if c.respond_to? :children
    p c.type
    p c.children
  end
end
