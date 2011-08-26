module TomDoc

  # TomDoc class needs Arg class.
  if RUBY_VERSION > '1.9'
    require_relative 'arg'
  else
    require 'yard-tomdoc/arg'
  end

  # This error is raised if comment is not valid TomDoc format.
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
    # Returns [String] documentation string.
    def message
      @doc
    end

    # Provide access to document string.
    #
    # Returns [String] documentation string.
    def to_s
      @doc
    end
  end

  # Model a TomDoc comment.
  class TomDoc
    attr_accessor :raw

    def initialize(text)
      @raw = text.to_s.strip
    end

    # Returns [String] raw comment text.
    def to_s
      @raw
    end

    # Returns [Boolean] true if valid TomDoc comment.
    def self.valid?(text)
      new(text).valid?
    end

    # Returns [Boolean] true if valid TomDoc comment, otherwise false.
    def valid?
      validate
    rescue InvalidTomDoc
      false
    end

    # Returns [Boolean] true if validation doesn't raise an error.
    def validate
      if !raw.include?('Returns')
        raise InvalidTomDoc.new("No `Returns' statement.")
      end

      if tomdoc.split("\n\n").size < 2
        raise InvalidTomDoc.new("No description section found.")
      end

      true
    end

    # Returns [String] cleansed comment text.
    def tomdoc
      #raw
      clean = raw.split("\n").map do |line|
        line =~ /^(\s*# ?)/ ? line.sub($1, '') : nil
      end.compact.join("\n")
      clean
    end

    # Returns [Array] document split into sections.
    def sections
      tomdoc.split("\n\n")
    end

    # Returns [String] first section.
    def description
      sections.first
    end

    # Returns [Array] list of arguments.
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

    # Returns [Array] list of examples.
    def examples
      if tomdoc =~ /(\s*Examples\s*(.+?)\s*(?:Returns|Raises))/m
        $2.split("\n\n")
      else
        []
      end
    end

    # Returns [Array] list of possible returns.
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

    # Returns [Array] list of possible errors that could be raised.
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
