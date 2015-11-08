module Ruhax
  class VarParser < MasterParser
    def initialize(node, options = {})
      @options = options
      @node = node
      @content = ""

      @variables = @options.has_key?(:local_variables) ? @options[:local_variables] : []
    end

    def parse
      if @node.children.length == 0
        return
      end

      children = @node.children.dup

      case @node.type
      when :lvasgn
        var_name = children.shift.to_s

        # Add 'var' keyword if it's a new var
        if !@variables.include? var_name
          @variables.push var_name
          @content << "var "
        end

        @content << var_name << " = "

        children.each {|child| @content << parse_new_node(child, @options).to_s}
        @content << ";"
      else
        @content << parse_new_node(node, @options).to_s
      end
    end

    def to_s
      @content
    end
  end
end
