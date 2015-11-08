# class Test{
#   public var final_score : Dynamic;
#   public static var static_var;
#   public function new() {}
#   public function my_function(arg1, arg2, optarg = 3) {
#     var my_var = arg2 + arg1;
#     arg1 = 10;
#     my_var = my_var - optarg;
#     Test.static_var = 5;
#     this.final_score = my_var;
#   }
# }

class Test
  def initialize
  end

  def my_function(arg1, arg2, optarg = 3)
    my_var = arg2 + arg1
    arg1 = 10
    my_var = my_var - optarg
    @@static_var = 5

    @final_score = my_var
  end
end
