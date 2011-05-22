#require 'tomdoc/tomdoc'
require 'yard-tomdoc/tomdoc'

module YARD

  class Docstring

    # Parse comments with TomDoc and then provide YARD with results. 
    #
    # comments - comment String
    #
    # Returns a String of parsed comments description.
    def parse_comments(comments)
      comment = [comments].flatten.join("\n")

      tomdoc = TomDoc::TomDoc.new(comment)

      tomdoc.examples.each {|ex| create_tag(:example, "\n" + ex) }

      tomdoc.args.each {|arg| create_tag(:param, "#{arg.name} #{arg.description}") }

      tomdoc.raises.each {|r| create_tag(:raise, r.sub(/\ARaises\s+/, '')) }

      tomdoc.returns.each do |r|
        if md = /\AReturns\s+([A-Z].*?)\s+/.match(r)
          klass = md[1]
          desc  = md.post_match
          create_tag(:return, "[#{klass}] #{desc}")
        else
          desc = r.sub(/\AReturns\s+/, '')
          create_tag(:return, desc)
        end
      end

      # notice we return the modified comment
      tomdoc.description.to_s
    end

  end

end

