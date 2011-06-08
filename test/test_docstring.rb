$:.unshift File.expand_path(File.dirname(__FILE__)) + "/../lib"

require 'minitest/autorun'

require "yard"
require "yard-tomdoc"
#require "yard-tomdoc-intern"

describe YARD::Docstring do

  before do
    @docstring = YARD::Docstring.new <<-eof
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

  it "should fill docstring with description" do
    @docstring.must_equal "Duplicate some text an arbitrary number of times."
  end

  it "should fill param tags" do
    tags = @docstring.tags(:param)
    tags.size.must_equal 2
    tags[0].name.must_equal 'text'
    tags[1].name.must_equal 'count'
  end
  
  it "should fill examples tags" do
    @docstring.tags(:example).size.must_equal 1
    @docstring.tag(:example).text.must_equal "multiplex('Tom', 4)\n  # => 'TomTomTomTom'"
  end
  
  it "should fill return tag" do
    @docstring.tag(:return).text.must_equal "the duplicated String."
  end

  it "should fill raise tag" do
    @docstring.tag(:raise).text.must_equal "ArgumentError if something bad happened"
  end
end
