require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"

module Commands
    extend self
    def help(payload) : Nil

        desc = String.new()

        Discord.cmdinfo.each do |var|
            desc = desc + "**#{var[0]}** - #{var[1]} \n"
        end

        # Embed
        Discord.client.create_message(payload.channel_id, "", Discord::Embed.new(
            title: "Help",
            description: desc,
            timestamp: Time.utc,
            colour: Color.new(0,255,81).to_u
        ))
    end
    Discord.cmdinfo["help"] = "Lists commands and their descriptions"
    Discord.commands["help"] = ->help(Discord::Message)
    Discord.commands["commands"] = ->help(Discord::Message)
end