require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"

module Commands
    extend self
    def example(payload) : Nil # Declares nil type as a temporary fix to a language bug, without : Nil this command-handler method will not work.
      Discord.client.create_message(payload.channel_id.value, "**Response**")
    end
    Discord.cmdinfo["example"] = "Example command, does nothing."
    Discord.commands["example"] = ->example(Discord::Message)
end