# An example of what this does can be found in ./commands/help.cr, used in embeds to create a color from RGB.

require "json"

struct Color
    include JSON::Serializable

    def initialize(@r : UInt8, @g : UInt8, @b : UInt8)
    end

    def to_u : UInt32
        return (@r.to_u<<16_u8) + (@g.to_u<<8_u8) + @b.to_u
    end
end
struct ColorA
    include JSON::Serializable

    def initialize(@r : UInt8, @g : UInt8, @b : UInt8, @a : UInt8)
    end

    def to_u : UInt32
        return (@a.to_u<<24_u8) + (@r.to_u<<16_u8) + (@g.to_u<<8_u8) + @b.to_u
    end
end

#puts Color.new(255,255,255).to_u
#puts 0xFFFFFF
#puts ColorA.new(255,255,255,127).to_u