module Ruhax
  ###
  # Parse the :return token
  ###
  class ReturnParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
    def parse
      @content << "return"

      @node.children.each do |child|
        @content << " "

        if child.is_a? AST::Node
          @content << parse_new_node(child, @options).to_s
        elsif child.is_a? Symbol
          @content << child.to_s
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
