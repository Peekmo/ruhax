module Ruhax
  class BeginParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    def parse
      @node.children.each_with_index do |child, index|
        result = parse_new_node(child, @options).to_s

        if index == @node.children.length - 1 && @options[:in_function]
          @content << "return "
        end

        result << ";" if result[-1] != ";" && @options[:in_function]
        @content << result << "\n" if result.length > 0
      end
    end

    def to_s
      @content
    end
  end
end
