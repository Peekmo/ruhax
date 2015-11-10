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
#     this.final_score = my_var;
#     return my_var;
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

    @final_score = my_var

    my_var
  end
end
