module Ruhax
  class VarModel
    attr_reader :name, :type, :value
    attr_writer :name, :type, :value

    def initialize(name, type = nil, value = nil)
      @name = name
      @type = type
      @value = value
    end
  end
end
