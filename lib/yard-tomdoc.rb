require 'tomparse'

module YARD

  module TomDoc
    #
    def self.metadata
      @metadata ||= (
        require 'yaml'
        YAML.load_file(File.dirname(__FILE__) + '/yard-tomdoc.yml')
      )
    end

    #
    def self.const_missing(name)
      metadata[name.to_s.downcase] || super(name)
    end
  end

  class Docstring
    # Parse comments with TomDoc and then provide YARD with results. 
    #
    # comments - [Array] of comment strings.
    #
    # Returns parsed comments description [String].
    def parse_comments(comments)
      comment = [comments].flatten.join("\n")

      tomdoc = TomParse.parse(comment)

      tomdoc.examples.each {|ex| create_tag(:example, "\n" + ex) }

      tomdoc.arguments.each {|arg| create_tag(:param, "#{arg.name} #{arg.description}") }

      last_argument = tomdoc.arguments.last
      last_argument.options.each do |opt|
        create_tag(:option, "#{last_argument.name} #{opt.description}")
      end

      tomdoc.raises.each {|r| create_tag(:raise, r.sub(/\ARaises\s+/, '')) }

      tomdoc.returns.each do |r|
        if md = /\AReturns\s+([A-Z].*?)\s+/.match(r)
          klass = md[1]
          desc  = md.post_match
          create_tag(:return, "[#{klass}] #{desc}")
        else
          desc = r.sub(/\AReturns\s+/, '')
          create_tag(:return, desc)
        end
      end

      create_tag(:yield, tomdoc.yields) if tomdoc.yields

      create_tag(:deprecated) if tomdoc.deprecated?

      create_tag(:private) if tomdoc.internal?

      # notice we return the modified comment
      tomdoc.description.to_s
    end
  end

end
