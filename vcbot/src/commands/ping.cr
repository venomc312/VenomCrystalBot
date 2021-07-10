require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"

module Commands
    extend self
    def ping(payload : Discord::Message) : Nil
        m = Discord.client.create_message(payload.channel_id, "Pong!")
        time = Time.utc - payload.timestamp
        Discord.client.edit_message(m.channel_id, m.id, "Pong! Time taken: #{time.total_milliseconds} ms.")
    end
    Discord.commands["ping"] = ->ping(Discord::Message)
end