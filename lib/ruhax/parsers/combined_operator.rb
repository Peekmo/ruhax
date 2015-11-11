module Ruhax
  ###
  # Parse "combined operators"
  #
  # It means, all that kind of operators : +=, -=
  ###
  class CombinedOperatorParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
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

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end
  end
end
