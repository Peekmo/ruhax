module Ruhax
  ###
  # Entry point and class from which every other parser must inherit
  #
  # Call the right parser for the given node and returns the parser
  ###
  class MasterParser
    # Constructor
    def initialize
    end

    # Parse the given node
    def parse_new_node(node, options = {})
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
      when :str, :int, :float, :true, :false, :nil, :sym
        parser = BaseTypeParser.new(node, node.type)

      # Blocks
      when :begin
        parser = BeginParser.new(node, options)

      # x += z
      when :op_asgn
        parser = CombinedOperatorParser.new(node, options)

      # return ....
      when :return
        parser = ReturnParser.new(node, options)

      # String interpolation
      when :dstr, :dsym
        parser = StrConcatParser.new(node, options)

      # Else, error
      else
        raise "Unsupported type " + node.type.to_s
      end

      parser.parse
      parser
    end
  end
end
