module Ruhax
  class VarParser < MasterParser
    def initialize(node, options = {})
      @options = options
      @node = node
      @content = ""

      @locale_variables = @options.has_key?(:locale_variables) ? @options[:locale_variables] : []
      @instance_variables = @options.has_key?(:instance_variables) ? @options[:instance_variables] : []
      @static_variables = @options.has_key?(:static_variables) ? @options[:static_variables] : []
      @current_class = @options.has_key?(:current_class) ? @options[:current_class] : nil
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
        if !@locale_variables.include? var_name
          @locale_variables.push var_name
          @content << "var "
        end

        @content << var_name << " = "

      # instance variables
      when :ivasgn
        if !@instance_variables.include? var_name
          @instance_variables.push var_name
        end

        @content << "this." << var_name[1.. var_name.length-1] << " = "

      # static variables
      when :cvasgn
        if !@static_variables.include? var_name
          @static_variables.push var_name
        end

        if @current_class == nil
          raise "Class variable called in non class context"
        end

        @content << @current_class << "." << var_name[2.. var_name.length-1] << " = "
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
