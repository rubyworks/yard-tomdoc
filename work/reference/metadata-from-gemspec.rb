
  # Just an idea, that metadata could be gotten from the gemspec. The name
  # of the gemspec would be required though, and you'd still need a fallback
  # just in case RubyGems wasn't being used.
  #
  # The biggest issue though it the #to_s on the gemspec return value is a bit
  # too simplistic. It needs to reduce the value to a basic type (String, Hash,
  # Array, Numeric). But how to know which?
  #
  # In the end, it doesn't seem like such a great idea. Too bad for RubyGems!


  # When a constant is missing, see if it is a metadata entry.
  # Metadata comes from the RubyGem, and fallsback to project index file.
  #
  # Arguments
  #
  #   name - [Symbol] constant name
  #
  # Returns metadata value.
  def self.const_missing(const_name)
    name = const_name.to_s.downcase
    begin
      Gem.loaded_specs[NAME].send(name).to_s
    rescue StandardError
      index[name] || super(const_name)
    end
  end

