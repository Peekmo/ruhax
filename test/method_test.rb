require 'test_helper'

class MethodTest < RuhaxTester
  def test_hello_word
    ruby = %q(
      class Main
        def self.main()
          puts "Hello World"
        end
      end
    )

    haxe = %q(
      class Main {
        public function new() {}
        public static function main() {
          return trace("Hello World");
        }
      }
    )

    check_return ruby, haxe
  end

  def test_different_methods
    ruby = %q(
      class Test
        def initialize
          test()
        end
        def test
          puts "test"
          hello
        end
        def hello
          puts "Hello World"
        end
      end
    )

    haxe = %q(
      class Test {
        public function new() {
          return test();
        }
        public function test() {
          trace("test");
          return hello();
        }
        public function hello() {
          return trace("Hello World");
        }
      }
    )

    check_return ruby, haxe
  end
end
