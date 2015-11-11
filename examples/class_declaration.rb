# class Test{
#   public var final_score : Dynamic;
#   public static var static_var = 0;
#   public function new() {}
#   public function my_function(arg1, arg2, optarg = 3) {
#     var my_var = arg2 + arg1;
#     arg1 = 10;
#     my_var += optarg;
#     Test.static_var = 5;
#     Test.static_var -=1;
#     var interpol = "test " + arg1 + " interpolation";
#     interpol = "test " + arg1;
#     interpol = arg1 + " interpolation";
#     interpol = arg1;
#     interpol = "new_string_sym";
#     this.final_score = my_var;
#     return [5, my_var, "string"];
#   }
#
#   public function regexp() {
#     var value = "ok";
#     var regexp = new EReg("^test" + value,"im");
#     regexp = new EReg(value,"im");
#     regexp = new EReg("^" + value + "test","im");
#     return regexp = new EReg("^test" + value + "test","im");
#   }
# }

class Test
  @@static_var = 0

  def my_function(arg1, arg2, optarg = 3)
    my_var = arg2 + arg1
    arg1 = 10
    my_var += optarg
    @@static_var = 5
    @@static_var -= 1


    interpol = "test #{arg1} interpolation"
    interpol = "test #{arg1}"
    interpol = "#{arg1} interpolation"
    interpol = "#{arg1}"
    interpol = :new_string_sym

    @final_score = my_var

    [5, my_var, "string"]
  end

  def regexp
    regexp = /^test#{@final_score}/im
    regexp = /#{@final_score}/im
    regexp = /^#{@final_score}test/im
    regexp = /^test#{@final_score}test/im
  end
end
