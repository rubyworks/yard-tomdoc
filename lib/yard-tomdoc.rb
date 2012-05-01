require 'tomparse'

module YARD

  module TomDoc
    # Metadata from the project's `yard-tomdoc.yml` fle.
    # 
    # Returns [Hash] of metadata.
    def self.metadata
      @metadata ||= (
        require 'yaml'
        YAML.load_file(File.dirname(__FILE__) + '/yard-tomdoc.yml')
      )
    end

    # When a constant is missing, see if it is a metadata entry.
    #
    # name - [Symbol] constant name
    #
    # Returns metadata value.
    def self.const_missing(name)
      metadata[name.to_s.downcase] || super(name)
    end

    # Parse comments with TomDoc and then provide YARD with results. 
    #
    # yard    - [Docstring,DocstringParser] instance of yard object
    # comment - [String] comment string
    #
    # Returns [TomDoc] instance of TomDoc 
    def self.yard_parse(yard, comment)
      tomdoc = TomParse.parse(comment)

      tomdoc.examples.each {|ex| yard.create_tag(:example, "\n" + ex) }

      # TODO: how to figure-out class of argument ?
      tomdoc.arguments.each {|arg| yard.create_tag(:param, "#{arg.name} #{arg.description}") }

      if last_argument = tomdoc.arguments.last
        last_argument.options.each do |opt|
          yard.create_tag(:option, "#{last_argument.name} #{opt.description}")
        end
      end

      tomdoc.raises.each {|r| yard.create_tag(:raise, r.sub(/\ARaises\s+/, '')) }

      tomdoc.returns.each do |r|
      # TODO: improve how we figure out class of argument
        if md = /\AReturns\s+([A-Z].*?)\s+/.match(r)
          klass = md[1]
          desc  = md.post_match
          yard.create_tag(:return, "[#{klass}] #{desc}")
        else
          desc = r.sub(/\AReturns\s+/, '')
          yard.create_tag(:return, desc)
        end
      end

      yard.create_tag(:yield, tomdoc.yields) if tomdoc.yields

      yard.create_tag(:deprecated, 'Do not use this in new code, and replace it when updating old code.') if tomdoc.deprecated?

      yard.create_tag(:private, 'Intended for internal use only.') if tomdoc.internal?

      tomdoc
    end
  end

  if VERSION >= '0.8'

    class DocstringParser
      def parse(content, object = nil, handler = nil)
        @object = object
        @handler = handler
        @raw_text = content

        if object
          text = parse_tomdoc(content)
        else        
          text = parse_content(content)
        end

        # Remove trailing/leading whitespace / newlines
        @text = text.gsub(/\A[\r\n\s]+|[\r\n\s]+\Z/, '')
        call_directives_after_parse
        call_after_parse_callbacks

        self
      end

      #
      def parse_tomdoc(content)
        tomdoc = TomDoc.yard_parse(self, content)
        tomdoc.description.to_s
      end

      public :create_tag
    end

  else

    class Docstring
      def parse_comments(comments)
        comment = [comments].flatten.join("\n")
        tomdoc  = TomDoc.yard_parse(self, comment)
        tomdoc.description.to_s  # return the modified comment
      end

      public :create_tag
    end

  end

end
