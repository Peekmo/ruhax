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
      var_name = children.shift.to_s

      case @node.type
      # locale variable
      when :lvasgn
        # Add 'var' keyword if it's a new var
        if !@variables.include? var_name
          @variables.push var_name
          @content << "var "
        end

        @content << var_name << " = "
      when :ivasgn
        @content << "this." << var_name[1.. var_name.length-1] << " = "
      else
        @content << parse_new_node(node, @options).to_s
      end

      children.each {|child| @content << parse_new_node(child, @options).to_s}
      @content << ";"
    end

    def to_s
      @content
    end
  end
end
