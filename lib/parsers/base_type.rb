module Ruhax
  class BaseTypeParser < MasterParser
    def initialize(node, type)
      @content = ""
      @type = type
      @node = node
    end

    def parse
      if @node.children.length == 0
        return
      end

      @content = @node.children[0].to_s
    end

    def to_s
      if @type == :str
        return "\"#{@content}\""
      end
      
      @content
    end
  end
end
