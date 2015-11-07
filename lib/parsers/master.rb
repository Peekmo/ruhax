module Ruhax
  class MasterParser
    def initialize
      @content = ""
    end

    def parse_new_node(node)
      parser = nil

      case node.type
      when :send
        parser = StatementParser.new(node)
      when :str
        parser = StringParser.new(node)
      else
        raise "Unsupported type " + node.type.to_s
      end

      parser.parse
      parser.to_s
    end
  end
end
