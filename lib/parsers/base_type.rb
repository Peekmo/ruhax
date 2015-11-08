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
      case @type
      when :nil
        @content = "null"
      when :str
        @content << "\"" << @node.children[0].to_s << "\""
      else
        @content = @node.children[0].to_s
      end
    end

    # Transform it to string
    def to_s
      @content
    end
  end
end
