$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruhax'
require 'minitest/autorun'

require 'parser/current'

require 'ruhax/parsers/master'
require 'ruhax/parsers/base_type'
require 'ruhax/parsers/call'
require 'ruhax/parsers/function'
require 'ruhax/parsers/args'
require 'ruhax/parsers/var'
require 'ruhax/parsers/class'
require 'ruhax/parsers/combined_operator'
require 'ruhax/parsers/return'
require 'ruhax/parsers/begin'
require 'ruhax/parsers/str_concat'
require 'ruhax/parsers/exec_string'
require 'ruhax/parsers/array'
require 'ruhax/parsers/regexp'
require 'ruhax/parsers/condition'

require 'ruhax/models/var'

class RuhaxTester < Minitest::Test
  def check_return(ruby, haxe)
    clean_haxe = haxe.gsub " ", ""
    clean_haxe = clean_haxe.gsub "\n", ""

    node = Parser::CurrentRuby.parse(ruby)
    parser = Ruhax::MasterParser.new
    result = parser.parse_new_node(node).to_s
    puts result

    clean_result = result.gsub "\n", ""
    clean_result = clean_result.gsub " ", ""

    assert_equal clean_result, clean_haxe
  end
end
