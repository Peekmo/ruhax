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
end
