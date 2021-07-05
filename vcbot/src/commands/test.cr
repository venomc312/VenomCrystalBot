require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"

module Commands
    extend self
    def test(payload)
      puts Discord.client.create_message(payload.channel_id.value, "**Response**")
    end
    Discord.commands["test"] = ->test(Discord::Message)
end