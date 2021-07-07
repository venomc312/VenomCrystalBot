require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"

module Commands
    extend self
    def ping(payload : Discord::Message)
        puts Discord.client.create_message(payload.channel_id.value, "Pong!")
       #767920553952542725
    end
    Discord.commands["ping"] = ->ping(Discord::Message)
end