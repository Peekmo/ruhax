require 'thor'
require 'parser/current'
require 'parsers/master'
require 'parsers/base_type'
require 'parsers/call'
require 'parsers/function'
require 'parsers/args'
require 'parsers/var'
require 'parsers/class'
require 'parsers/combined_operator'
require 'parsers/return'
require 'parsers/begin'
require 'models/var'

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
