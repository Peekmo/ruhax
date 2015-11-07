module Ruhax
  # Parser for all basic types
  class BaseTypeParser < MasterParser
    # Constructor
    # @param node AST::Node node to parse
    # @param type Symbol ruby type
    def initialize(node, type)
      @content = ""
      @type = type
      @node = node
    end

    # Parse the node
    def parse
      if @node.children.length == 0
        return
      end

      @content = @node.children[0].to_s
    end

    # Transform it to string
    def to_s
      if @type == :str
        return "\"#{@content}\""
      end

      @content
    end
  end
end
