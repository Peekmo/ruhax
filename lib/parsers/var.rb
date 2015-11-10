module Ruhax
  ###
  # Parse all kind of variable
  #
  # Registers in options :
  # - locale_variables
  # - instance_variables (@)
  # - static_variables (@@)
  ###
  class VarParser < MasterParser
    def initialize(node, options = {})
      @options = options
      @node = node
      @content = ""

      @in_function = @options.has_key?(:in_function) ? @options[:in_function] : false
      @locale_variables = @options.has_key?(:locale_variables) ? @options[:locale_variables] : {}
      @instance_variables = @options.has_key?(:instance_variables) ? @options[:instance_variables] : {}
      @static_variables = @options.has_key?(:static_variables) ? @options[:static_variables] : {}
      @current_class = @options.has_key?(:current_class) ? @options[:current_class] : nil
    end

    ###
    # Process parsing
    ###
    def parse
      if @node.children.length == 0
        return
      end

      children = @node.children.dup
      var_name = children.shift.to_s

      current_var = nil
      case @node.type
      # locale variable
      when :lvasgn
        # Add 'var' keyword if it's a new var
        if !@locale_variables.has_key?(var_name.to_sym)
          @locale_variables[var_name.to_sym] = VarModel.new(var_name)
          @content << "var "
        end

        @content << var_name
        current_var = @locale_variables[var_name.to_sym]

      # instance variables
      when :ivasgn
        var_name = var_name[1.. var_name.length-1]
        if !@instance_variables.has_key?(var_name.to_sym)
          @instance_variables[var_name.to_sym] = VarModel.new(var_name)
        end

        if @in_function
          @content << "this." << var_name
        end
        current_var = @instance_variables[var_name.to_sym]

      # static variables
      when :cvasgn
        var_name = var_name[2.. var_name.length-1]
        if !@static_variables.has_key?(var_name.to_sym)
          @static_variables[var_name.to_sym] = VarModel.new(var_name)
        end

        if @current_class == nil
          raise "Class variable called in non class context"
        end

        if @in_function
          @content << @current_class << "." << var_name
        end
        current_var = @static_variables[var_name.to_sym]

      else
        @content << parse_new_node(node, @options).to_s
      end

      value = ""
      if children.length > 0
        @content << " = " if @in_function
        children.each {|child| value << parse_new_node(child, @options).to_s}
      end

      if @in_function && !@options[:no_value]
        @content << value << ";"
      elsif current_var && !@options[:no_value]
        current_var.value = value
      end
    end

    ###
    # Return string value of the parser
    ###
    def to_s
      @content
    end
  end
end
