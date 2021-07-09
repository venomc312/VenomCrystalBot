require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"

module Commands
    extend self
    def status(payload)
      puts Discord.client.create_message(payload.channel_id.value, "**Response**")
    end
    Discord.commands["status"] = ->status(Discord::Message)
end