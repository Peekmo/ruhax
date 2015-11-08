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
        parser = CallParser.new(node, options)

      # Function args
      when :args
        parser = ArgsParser.new(node)

      # Class declaration
      when :class
        parser = ClassParser.new(node)

      # Assign var
      when :lvasgn, :ivasgn, :cvasgn
        parser = VarParser.new(node, options)

      when :lvar, :ivar
        return unless node.children.length > 0
        return node.children[0].to_s

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
          result = parser.parse_new_node(child, options).to_s

          content << result << "\n" if result.length > 0
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
