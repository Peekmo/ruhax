module Ruhax
  ###
  # Parse a function declaration
  #
  # It takes care of to do not have the same locale variable declaration
  # The function called "initialize" will be translated into "new"
  ###
  class FunctionParser < MasterParser
    attr_reader :visibility

    # Constructor
    def initialize(node, options = {})
      @content = ""
      @node = node
      @is_static = false
      @args = ""
      @options = options
      @locale_options = @options.merge({
        'locale_variables': {},
        'in_function': true
      })

      @visibility = options.has_key?(:visibility) ? options[:visibility] : "public"
    end

    # Parse a (:def) process
    def parse
      if @node.children.length == 0
        return
      end

      # 'cause it's a frozen array
      children = @node.children.dup

      @name = children.shift
      if @name.is_a?(AST::Node)
        if @name.type == :self
          @name = children.shift
          @is_static = true
        else
          raise "Unknown method type " << name.type.to_s
        end
      end

      # Transform 'initialize' into 'new' (haxe keyword)
      if @name == :initialize
        @options[:has_constructor] = true
        @name = :new
      end

      children.each do |child|
        is_node = child.is_a? AST::Node

        if is_node && child.type == :args
          @args = parse_new_node(child)
          @locale_options[:locale_variables] = @args.variables
        elsif is_node
          has_block = false
          if child.type == :begin
            has_block = true
          end

          if !has_block
            @content << "return "
          end

          @content << parse_new_node(child, @locale_options).to_s

          if !has_block
            @content << ";" unless @content[-1, 1] == ";"
          end
        end
      end
    end

    ###
    # Return string value of the parser
    ###
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
