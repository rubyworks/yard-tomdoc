require 'helper.rb'

require "yard"
require "yard-tomdoc"

describe YARD::Docstring do

  before do
    @docstring = YARD::Docstring.new <<-eof
# Duplicate some text an arbitrary number of times.
# 
# text  - The String to be duplicated.
# count - The Integer number of times to duplicate the text.
# 
# Examples
#   multiplex('Tom', 4)
#   # => 'TomTomTomTom'
#
# Returns the duplicated String.
#
# Raises ArgumentError if something bad happened
eof
  end

  it "should fill docstring with description" do
    @docstring.assert == "Duplicate some text an arbitrary number of times."
  end

  it "should fill param tags" do
    tags = @docstring.tags(:param)
    tags.size.assert == 2
    tags[0].name.assert == 'text'
    tags[1].name.assert == 'count'
  end
  
  it "should fill examples tags" do
    @docstring.tags(:example).size.assert == 1
    @docstring.tag(:example).text.assert == "multiplex('Tom', 4)\n  # => 'TomTomTomTom'"
  end
  
  it "should fill return tag" do
    @docstring.tag(:return).text.assert == "the duplicated String."
  end

  it "should fill raise tag" do
    @docstring.tag(:raise).text.assert == "ArgumentError if something bad happened"
  end

  describe "Internal description" do

    it "should fill private tag" do
      docstring = YARD::Docstring.new("# Internal: It will do a big things in future")
      docstring.tag(:private).text.assert == "It will do a big things in future"
    end

  end

  describe "Deprecated description" do

    it "should fill deprecated tag" do
      docstring = YARD::Docstring.new("# Deprecated: Don't use this.")
      docstring.tag(:deprecated).text.assert == "Don't use this."
    end

  end
end
