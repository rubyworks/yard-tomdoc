require File.dirname(__FILE__) + "/../lib/yard-tomdoc"

describe YARD::Docstring do
  before(:all) do
    @docstring = YARD::Docstring.new(<<-eof)
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
    @docstring.should == "Duplicate some text an arbitrary number of times."
  end
  
  it "should fill param tags" do
    tags = @docstring.tags(:param)
    tags.size.should == 2
    tags[0].name.should == 'text'
    tags[1].name.should == 'count'
  end
  
  it "should fill examples tags" do
    @docstring.tags(:example).size.should == 1
    @docstring.tag(:example).text.should == "multiplex('Tom', 4)\n  # => 'TomTomTomTom'"
  end
  
  it "should fill return tag" do
    @docstring.tag(:return).text.should == "the duplicated String."
  end
  
  it "should fill raise tag" do
    @docstring.tag(:raise).text.should == "ArgumentError if something bad happened"
  end
end
