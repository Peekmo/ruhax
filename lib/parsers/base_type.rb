module Ruhax
  ###
  # Parse basic types as str, int, float, nil
  #
  # Note : nil will be translated into null
  ###
  class BaseTypeParser < MasterParser
    # Constructor
    # @param node AST::Node node to parse
    # @param type Symbol ruby type
    def initialize(node, type)
      @content = ""
      @type = type
      @node = node
    end

    ###
    # Process parsing
    ###
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

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end
  end
end
