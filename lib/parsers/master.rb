module Ruhax
  # Most important parser
  # Every parser should inherit from it
  class MasterParser
    # Constructor
    def initialize
      @content = ""
    end

    # Parse the given node
    def parse_new_node(node)
      parser = nil

      case node.type
      # Any statement
      when :send
        parser = StatementParser.new(node)

      # Basic type
      when :str, :int, :float, :true, :false
        parser = BaseTypeParser.new(node, node.type)

      # Blocks
      when :begin
        node.children.each do |child|
          parser = MasterParser.new
          @content << parser.parse_new_node(child) << "\n"
        end

        return @content

      # Else, error
      else
        raise "Unsupported type " + node.type.to_s
      end

      parser.parse
      parser.to_s
    end
  end
end
