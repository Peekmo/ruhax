module Ruhax
  ###
  # Executable string parsing
  #
  # `ls -a` => Sys.command("ls", ["-a"])
  ###
  class ExecStringParser < MasterParser
    def initialize(node, options)
      @node = node
      @options = options
      @content = ""
    end

    ###
    # Process parsing
    ###
    def parse
      @node.children.each do |child|
        result = parse_new_node(child, @options.merge({
          no_new_lines: true
        })).to_s

        if child.type != :str
          @content << " + " << result << " + "
        else
          @content << result
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
