module Ruhax
  ###
  # REGEXP parsing
  #
  # "/foo#{bar}/i"
  ###
  class RegexpParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
    def parse
      if @node.children.length == 0
        return
      end

      @content << "new EReg("
      previous_type = nil
      @node.children.each_with_index do |child, index|
        # Modifiers
        if child.is_a?(AST::Node) && child.type == :regopt
          @content << ",\""
          child.children.each do |c|
            if c.is_a? AST::Node
              @content << parse_new_node(c, @options).to_s
            else
              @content << c.to_s
            end
          end

          @content << "\""

        # Content of the regexp
        else
          result = parse_new_node(child, @options.merge({
            no_new_lines: true
          })).to_s

          # Interpolation
          if child.type != :str
            @content << " + " if previous_type == :str
            @content << result
          else
            @content << " + " if index != 0
            @content << result
          end
        end

        previous_type = child.type
      end

      @content << ")"
    end

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end
  end
end
