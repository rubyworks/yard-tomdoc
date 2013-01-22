class Example
  # Public: Duplicate some text an arbitrary number of times.
  #
  # text  - The String to be duplicated.
  #         What if it has multiple lines?
  # count - The Integer number of times to duplicate the text.
  #         This one could too.
  #
  # Examples
  #
  #   multiplex('Tom', 4)
  #   # => 'TomTomTomTom'
  #
  # Returns the duplicated String.
  def multiplex(text, count)
    text * count
  end
end
