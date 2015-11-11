module Ruhax
  ###
  # Array parsing
  ###
  class ArrayParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
    def parse
      @content << "["
      @node.children.each_with_index do |child, index|
        result = parse_new_node(child, @options).to_s

        @content << result
        @content << ", " if index != @node.children.length - 1
      end
      @content << "]"
    end

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end
  end
end
