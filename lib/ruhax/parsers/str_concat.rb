module Ruhax
  ###
  # String concatenation happens here.
  #
  # ATM, just "#{myvar}" or "ok" + "ok" are working
  ###
  class StrConcatParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
    def parse
      previous_type = nil
      @node.children.each_with_index do |child, index|
        result = parse_new_node(child, @options.merge({
          no_new_lines: true
        })).to_s

        if child.type != :str
          @content << " + " if previous_type == :str
          @content << result
          @content << " + " if index != @node.children.length - 1
        else
          @content << result
        end

        previous_type = child.type
      end
    end

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end
  end
end
