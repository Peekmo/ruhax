module Ruhax
  class StringParser < MasterParser
    def initialize(node)
      @content = ""
      @node = node
    end

    def parse
      if @node.children.length == 0
        return
      end

      @content = @node.children[0].to_s
    end

    def to_s
      @content
    end
  end
end
