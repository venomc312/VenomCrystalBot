require "../../lib/discordcr/src/discordcr"
require "../discord"
require "json"
require "http/client"

module Commands
    extend self
    def status(payload) : Nil
        response = HTTP::Client.get "http://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001?addr=69.30.205.147&format=json"
        if response.body.includes?("garrysmod")
            Discord.client.create_message(payload.channel_id, "VTB is currently up!")
        else
            Discord.client.create_message(payload.channel_id, "VTB is currently down!")
        end
    end
    Discord.commands["status"] = ->status(Discord::Message)
end