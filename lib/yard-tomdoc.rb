require File.dirname(__FILE__) + "/tomdoc"

module YARD
  class Docstring
    def parse_comments(comments)
      tomdoc = TomDoc::TomDoc.new(comments)
      tomdoc.examples.each {|ex| create_tag(:example, "\n" + ex) }
      tomdoc.args.each {|arg| create_tag(:param, "#{arg.name} #{arg.description}") }
      tomdoc.raises.each {|r| create_tag(:raise, r.sub(/\ARaises\s+/, '')) }
      tomdoc.returns.each {|r| create_tag(:return, r.sub(/\AReturns\s+/, '')) }
      tomdoc.description
    end
  end
end