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

  def test_regex_with_static_interpolation
    ruby = %q(
      class Test
        @@final_score = "10"

        def self.main()
          regexp = /^test#{@@final_score}/im
          regexp = /#{@@final_score}/im
          regexp = /^#{@@final_score}test/im
          regexp = /^test#{@@final_score}test/im
        end
      end
    )

    haxe = %q(
      class Test {
        public static var final_score = "10";

        public function new() {}
        public static function main() {
          var regexp = new EReg("^test" + Test.final_score,"im");
          regexp = new EReg(Test.final_score,"im");
          regexp = new EReg("^" + Test.final_score + "test","im");
          return regexp = new EReg("^test" + Test.final_score + "test","im");
        }
      }
    )

    check_return ruby, haxe
  end
end
