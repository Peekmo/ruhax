module Ruhax
  ###
  # Model of a variable (of any kind)
  ###
  class VarModel
    attr_reader :name, :type, :value
    attr_writer :name, :type, :value

    ###
    # name : variable name
    # type : variable type (haxe)
    # value : default value of the variable
    ###
    def initialize(name, type = nil, value = nil)
      @name = name
      @type = type
      @value = value
    end
  end
end
