module Ruhax
  # Operators += -= *= etc...
  class CombinedOperatorParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    def parse
      if @node.children.length != 3
        return
      end

      @node.children.each_with_index do |child, k|
        if child.is_a? AST::Node
          result = parse_new_node(child, @options.merge({
            no_value: true
          })).to_s
        else
          result = child.to_s
        end

        @content << result
        if k == 1
          @content << "="
        end
      end

      @content << ";"
    end

    def to_s
      @content
    end
  end
end
