module Ruhax
  # Parse function's args
  class ArgsParser < MasterParser
    attr_reader :variables
    
    # constructor
    def initialize(node)
      @node = node
      @content = ""
      @variables = []
    end

    def parse
      if @node.children.length == 0
        return
      end

      @node.children.each_with_index do |child, index|
        if child.children.length == 0
          return
        end

        variable, default_value = child.children
        @variables.push variable.to_s
        @content << variable.to_s

        if child.type == :optarg && default_value
          @content << " = " << parse_new_node(default_value).to_s
        end

        if index != @node.children.length - 1
          @content << ", "
        end
      end
    end

    def to_s
      @content
    end
  end
end
