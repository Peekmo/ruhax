module Ruhax
  # Parse everything that starts with 'send'
  class StatementParser < MasterParser
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

      @node.children.each do |child|
        is_symbol = child.is_a? Symbol

        # New node
        if child.is_a? AST::Node
          @has_node = true

          parse ||= parse_new_node child
          @content << parse

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
        @content << ");"
      end
    end

    # Returns the content
    def to_s
      @content
    end
  end
end
