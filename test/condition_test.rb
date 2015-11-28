require 'test_helper'

class ConditionTest < RuhaxTester
  def test_conditions
    ruby = %q(
      class Test
        def compare(a, b)
          @a = a
          @b = b

          my_var = @a == 3 ? 0 : 1
          if my_var >= @b
            puts "foo"

            if my_var == @b
              puts "ok"
            end
          elsif @b > @a
            if my_var == 0
              puts "sub if"
            end
          else
            puts "else"
          end
        end
      end
    )

    haxe = %q(
      class Test {
        public var a : Dynamic;
        public var b : Dynamic;

        public function new() {}
        public function compare(a, b) {
          this.a = a;
          this.b = b;

          var my_var = this.a == 3 ? 0 : 1;
          return if (my_var >= this.b) {
            trace("foo");

            if (my_var == this.b) {
              trace("ok");
            }
          } else if (this.b > this.a) {
            if (my_var == 0) {
              trace("sub if");
            }
          } else {
            trace ("else");
          }
        }
      }
    )

    check_return ruby, haxe
  end
end
