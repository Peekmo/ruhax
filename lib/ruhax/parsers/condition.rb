module Ruhax
  ###
  # If parsing
  # Elsif not yet implemented
  ###
  class ConditionParser < MasterParser

    # Constructor
    def initialize(node, options = {})
      @node = node
      @options = options
      @content = ""
      @condition = ""
      @ternary_true_part = ""
      @ternary_false_part = ""
    end

    # Parse a (:if) process
    def parse
      if @node.children.length == 0
        return
      end

      # 'cause it's a frozen array
      children = @node.children.dup

      # Get the if statement
      @condition = parse_new_node(children.shift).to_s

      count_nodes = BeginParser.new(children.first, @options).count_nodes

      # Multiple instructions if statement
      if count_nodes > 1
        @condition = "if (" + @condition + ") {\n"
        has_begin = false # For elsif

        children.each_with_index do |child, index|
          if child.is_a? AST::Node
             # Elsif operator
            if child.type == :if && children.length > 1 && has_begin
              @content << "else "
              @content << parse_new_node(child).to_s
             # Else
            elsif index == children.length - 1 && children.length > 1
              @content << "\n} else {\n"
              @content << parse_new_node(child).to_s
            else
              if child.type == :begin
                has_begin = true
              end

              @content << parse_new_node(child).to_s
            end
          end
        end
      else # Ternary operator
        if children.length == 2
          @ternary_true_part << parse_new_node(children[0]).to_s
          @ternary_false_part << parse_new_node(children[1]).to_s
        end
      end
    end

    # Write function
    def to_s
      data = ""
      if @ternary_true_part.empty?
        data << @condition
        data << @content
        data << "\n}"
      else
        data << @condition + " ? " + @ternary_true_part + " : " + @ternary_false_part
      end
      data
    end
  end
end
