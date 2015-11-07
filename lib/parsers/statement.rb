module Ruhax
  # Parse everything that starts with 'send'
  class StatementParser < MasterParser
    # Constructor
    def initialize(node)
      @node = node
      @content = ""
    end

    # Parse the node
    def parse
      if @node.children.length == 0
        return
      end

      @node.children.each do |child|
        if child.is_a? AST::Node
          parse ||= parse_new_node child
          @content << parse
        end
      end
    end

    def to_s
      @content
    end
  end
end
