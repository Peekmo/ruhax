module Ruhax
  # Parse everything that starts with 'send'
  class CallParser < MasterParser
    @@is_in_function_call = false

    # Constructor
    def initialize(node)
      @node = node
      @content = ""
      @is_method = false
      @has_node = false
    end

    # Parse the node
    def parse
      if @node.children.length == 0
        return
      end

      @node.children.each_with_index do |child, index|
        is_symbol = child.is_a? Symbol

        # New node
        if child.is_a? AST::Node
          @has_node = true

          root_call = false
          if @is_method && !@@is_in_function_call
            root_call = true
            @@is_in_function_call = true
          end

          parse = parse_new_node(child).to_s
          @content << parse

          if @is_method && index != @node.children.length - 1
            @content << ", "
          end

          if root_call
            @@is_in_function_call = false
          end

        # Method call
        elsif is_symbol && !@has_node
          str = ""
          case child
          when :puts, :print
            str = "trace"
          else
            str = child.to_s
          end

          @content << str << "("
          @is_method = true

        elsif is_symbol && @has_node
          @content << " " << child.to_s << " "
        end
      end

      if @is_method
        @content << ")"

        if !@@is_in_function_call
          @content << ";"
        end
      end
    end

    # Returns the content
    def to_s
      @content
    end
  end
end
