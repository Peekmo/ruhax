module Ruhax
  # Parse "def"
  class FunctionParser < MasterParser
    # Constructor
    def initialize(node)
      @content = ""
      @node = node
    end

    def parse

    end

    def to_s
      @content
    end
  end
end
