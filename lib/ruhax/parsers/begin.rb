module Ruhax
  ###
  # This parser will translate a block of multiple instructions
  #
  # It does not output anything except its children's content
  # Set :no_new_lines options to don't get a new line between each children's
  # instructions
  ###
  class BeginParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
    def parse
      need_semilicon = (@options[:in_function] && !@options[:no_new_lines]) ||
        (!@options[:in_function] && !@options[:current_class] && !@options[:no_new_lines])

      @node.children.each_with_index do |child, index|
        result = parse_new_node(child, @options).to_s

        if index == @node.children.length - 1 && (@options[:in_function] && !@options[:no_new_lines])
          @content << "return "
        end

        result << ";" if result[-1] != ";" && result[-1] != "\n" && result[-1] != "}" && need_semilicon
        if result.length > 0
          @content << result
          @content <<  "\n" if !@options[:no_new_lines]
        end
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
