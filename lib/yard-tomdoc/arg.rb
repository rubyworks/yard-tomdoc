module TomDoc
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
end
