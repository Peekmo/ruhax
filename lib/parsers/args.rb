module Ruhax
  # Parse function's args
  class ArgsParser < MasterParser
    # constructor
    def initialize(node)
      @node = node
      @content = ""
    end

    def parse
      if @node.children.length == 0
        return
      end
    end

    def to_s
      @content
    end
  end
end
