require 'test_helper'

class StringTest < RuhaxTester
  def test_interpolation
    ruby = %q(
      class Test
        def self.main()
          arg1 = "test"

          puts "test #{arg1} interpolation"
          puts "test #{arg1}"
          puts "#{arg1} interpolation"
          puts "#{arg1}"
          puts :new_string_sym
        end
      end
    )

    haxe = %q(
      class Test {
        public function new() {}
        public static function main() {
          var arg1 = "test";
          trace("test " + arg1 + " interpolation");
          trace("test " + arg1);
          trace(arg1 + " interpolation");
          trace(arg1);
          return trace("new_string_sym");
        }
      }
    )

    check_return ruby, haxe
  end
end
