require 'yard'

module TomDoc
  class InvalidTomDoc < RuntimeError
    # Create new InvalidTomDoc object.
    #
    # doc - document string
    #
    def initialize(doc)
      @doc = doc
    end

    # Provide access to document string.
    #
    # Returns String.
    def message
      @doc
    end

    # Provide access to document string.
    #
    # Returns String.
    def to_s
      @doc
    end
  end
  
  class Arg
    attr_accessor :name, :description

    # Create new Arg object.
    #
    # name        - name of argument
    # description - arguments description
    #
    def initialize(name, description = '')
      @name = name.to_s.intern
      @description = description
    end

    # Is this an optional argument?
    #
    # Returns Boolean.
    def optional?
      @description.downcase.include? 'optional'
    end
  end

  class TomDoc
    attr_accessor :raw

    def initialize(text)
      @raw = text.to_s.strip
    end

    def to_s
      @raw
    end

    def self.valid?(text)
      new(text).valid?
    end

    def valid?
      validate
    rescue InvalidTomDoc
      false
    end

    def validate
      if !raw.include?('Returns')
        raise InvalidTomDoc.new("No `Returns' statement.")
      end

      if tomdoc.split("\n\n").size < 2
        raise InvalidTomDoc.new("No description section found.")
      end

      true
    end

    def tomdoc
      raw
    end

    def sections
      tomdoc.split("\n\n")
    end

    def description
      sections.first
    end

    def args
      args = []
      last_indent = nil

      return args unless sections[1]

      sections[1].split("\n").each do |line|
        next if line.strip.empty?
        indent = line.scan(/^\s*/)[0].to_s.size

        if last_indent && indent > last_indent
          args.last.description += line.squeeze(" ")
        else
          param, desc = line.split(" - ")
          args << Arg.new(param.strip, desc.strip) if param && desc
        end

        last_indent = indent
      end

      args
    end

    def examples
      if tomdoc =~ /(\s*Examples\s*(.+?)\s*(?:Returns|Raises))/m
        $2.split("\n\n")
      else
        []
      end
    end

    def returns
      if tomdoc =~ /^\s*(Returns.+)/m
        lines = $1.split("\n")
        statements = []

        lines.each do |line|
          next if line =~ /^\s*Raises/
          if line =~ /^\s+/
            statements.last << line.squeeze(' ')
          else
            statements << line
          end
        end

        statements
      else
        []
      end
    end

    def raises
      if tomdoc =~ /^\s*(Raises.+)/m
        lines = $1.split("\n")
        statements = []

        lines.each do |line|
          if line =~ /^\s+/
            statements.last << line.squeeze(' ')
          else
            statements << line
          end
        end

        statements
      else
        []
      end
    end
  end
end
