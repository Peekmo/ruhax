module Ruhax
  # Parse "def"
  class FunctionParser < MasterParser
    # Constructor
    def initialize(node)
      @content = ""
      @node = node
      @is_static = false
    end

    def parse
      if @node.children.length == 0
        return
      end

      # 'cause it's a frozen array
      children = @node.children.dup

      # @TODO visibility
      name = children.shift
      if name.is_a?(AST::Node)
        if name.type == :self
          name = children.shift
          @is_static = true
        else
          raise "Unknown method type " << name.type.to_s
        end
      end

      if @is_static
        @content = "public static function " << name.to_s
      else
        @content = "public function " << name.to_s
      end

      children.each do |child|
        is_node = child.is_a? AST::Node

        if is_node && child.type == :args
          @content << "("
          @content << parse_new_node(child)
          @content << ") {\n"
        else
          @content << parse_new_node(child)
        end
      end

      @content << "\n}"
    end

    def to_s
      @content
    end
  end
end
