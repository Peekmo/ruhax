require 'thor'
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

require 'ruhax/models/var'

module Ruhax
  class RuhaxCli < Thor
    option :src, :require => true
    option :debug, :type => :boolean
    desc "build", "Build the haxe code from your ruby code"
    def build
      src = options[:src]

      node = Parser::CurrentRuby.parse(File.read(src))
      if options[:debug]
        puts "******** NODE *******"
        p node
        puts "*********************"
      end

      parser = Ruhax::MasterParser.new
      puts parser.parse_new_node(node).to_s
    end
  end
end
