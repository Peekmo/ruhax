module Ruhax
  # Parse "def"
  class FunctionParser < MasterParser
    attr_reader :visibility

    # Constructor
    def initialize(node, options = {})
      @content = ""
      @node = node
      @is_static = false
      @args = ""

      @visibility = options.has_key?(:visibility) ? options[:visibility] : "public"
    end

    # Parse a (:def) process
    def parse
      if @node.children.length == 0
        return
      end

      # 'cause it's a frozen array
      children = @node.children.dup

      name = children.shift
      if name.is_a?(AST::Node)
        if name.type == :self
          @name = children.shift
          @is_static = true
        else
          raise "Unknown method type " << name.type.to_s
        end
      end

      children.each do |child|
        is_node = child.is_a? AST::Node

        if is_node && child.type == :args
          @args = parse_new_node(child)
        else
          @content << parse_new_node(child).to_s
        end
      end
    end

    # Write function
    def to_s
      if @is_static
        data = @visibility << " static function " << @name.to_s
      else
        data = @visibility << " function " << @name.to_s
      end

      data << "(" << @args.to_s << ") {\n"
      data << @content
      data << "\n}\n"

      data
    end
  end
end
