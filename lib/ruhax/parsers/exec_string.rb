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
      args = []

      @node.children.each do |child|
        result = parse_new_node(child, @options.merge({
          no_new_lines: true
        })).to_s

        commands = result.split("\n")
        commands.each_with_index do |command, index|
          if index > 0
            build_content args
            args = []
          end

          is_string = child.type == :str
          command = command[1..-2] if is_string
          command.split(" ").each do |arg|
            arg = "\"" << arg << "\"" if is_string
            args.push(arg) if (arg != "" && arg != "\"\"")
          end
        end
      end

      build_content args
    end

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end

    private
    ###
    # Builds a command call
    # @param array args Arguments for the command
    ###
    def build_content(args)
      if args.length > 0
        @content << "Sys.command(" << args.shift << ", [" << args.join(",") << "]);"
      end
    end
  end
end
