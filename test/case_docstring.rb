$:.unshift File.dirname(__FILE__) + "/../lib"

require "yard"
require "yard-tomdoc"

KO.case 'YARD::Docstring' do

  setup do
    @docstring = ::YARD::Docstring.new <<-eof
Duplicate some text an arbitrary number of times.

text  - The String to be duplicated.
count - The Integer number of times to duplicate the text.

Examples
  multiplex('Tom', 4)
  # => 'TomTomTomTom'

Returns the duplicated String.

Raises ArgumentError if something bad happened
eof
  end

  test "should fill docstring with description" do
    @docstring == "Duplicate some text an arbitrary number of times."
  end

  test "should fill param tags" do
    tags = @docstring.tags(:param)
    tags.size    == 2      &&
    tags[0].name == 'text' &&
    tags[1].name == 'count'
  end
  
  test "should fill examples tags" do
    @docstring.tags(:example).size == 1 &&
    @docstring.tag(:example).text  == "multiplex('Tom', 4)\n  # => 'TomTomTomTom'"
  end
  
  test "should fill return tag" do
    @docstring.tag(:return).text == "the duplicated String."
  end

  test "should fill raise tag" do
    @docstring.tag(:raise).text == "ArgumentError if something bad happened"
  end
end
