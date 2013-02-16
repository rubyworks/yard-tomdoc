class Example
  # Public: Duplicate some text an arbitrary number of times. [String]
  #
  # text  - The String to be duplicated.
  #         What if it has multiple lines?
  # count - The Integer number of times to duplicate the text.
  #         This one could too.
  #
  # Example
  #
  #   class Child
  #     extend AccountInheritance
  #
  #     belongs_to :parent
  #
  #     inherits_account_from :parent
  #   end
  #
  def multiplex(text, count)
    text * count
  end
end
