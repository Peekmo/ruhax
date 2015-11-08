require 'thor'
require 'parser/current'
require 'parsers/master'
require 'parsers/base_type'
require 'parsers/call'
require 'parsers/function'
require 'parsers/args'
require 'parsers/var'
require 'parsers/class'

module Ruhax
  class RuhaxCli < Thor
    option :src, :require => true
    desc "build", "Build the haxe code from your ruby code"
    def build
      src = options[:src]

      node = Parser::CurrentRuby.parse(File.read(src))

      parser = Ruhax::MasterParser.new
      puts parser.parse_new_node(node).to_s
    end
  end
end
