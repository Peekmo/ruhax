module Ruhax
  # Most important parser
  # Every parser should inherit from it
  class MasterParser
    # Constructor
    def initialize
    end

    # Parse the given node
    def parse_new_node(node, options = {})
      content = ""
      parser = nil

      case node.type
      # Any function call
      when :send
        parser = CallParser.new(node)

      # Function args
      when :args
        parser = ArgsParser.new(node)

      # Function declaration
      when :def, :defs
        parser = FunctionParser.new(node, options)

      # Basic types
      when :str, :int, :float, :true, :false, :nil
        parser = BaseTypeParser.new(node, node.type)

      # Blocks
      when :begin
        node.children.each do |child|
          parser = MasterParser.new
          content << parser.parse_new_node(child).to_s << "\n"
        end

        return content

      # Else, error
      else
        raise "Unsupported type " + node.type.to_s
      end

      parser.parse
      parser
    end
  end
end
