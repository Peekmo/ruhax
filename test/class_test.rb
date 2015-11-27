require 'test_helper'

class ClassTest < RuhaxTester
  def test_class_attributes
    ruby = %q(
      class Test
        @@count = 0

        def initialize(name, age = 10)
          @name = name
          @age = age

          @@count += 1
          callable
        end

        def callable
          puts "Callable"
        end
      end
    )

    haxe = %q(
      class Test {
        public var name : Dynamic;
        public var age : Dynamic;
        public static var count = 0;

        public function new(name, age = 10) {
          this.name = name;
          this.age = age;
          Test.count += 1;
          return callable();
        }

        public function callable() {
          return trace("Callable");
        }
      }
    )

    check_return ruby, haxe
  end
end
