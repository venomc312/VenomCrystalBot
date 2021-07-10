require "../../lib/discordcr/src/discordcr"
require "../color"
require "../discord"
require "json"
require "http/client"

module Commands
    extend self
    def status(payload) : Nil
        response = HTTP::Client.get "http://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001?addr=69.30.205.147&format=json"
        if response.body.includes?("garrysmod")
            Discord.client.create_message(payload.channel_id, "", Discord::Embed.new(
                title: "Venom's Train Build",
                description: "Online",
                timestamp: Time.utc,
                colour: Color.new(0,255,81).to_u
            ))
        else
            Discord.client.create_message(payload.channel_id, "", Discord::Embed.new(
                title: "Venom's Train Build",
                description: "Offline",
                timestamp: Time.utc,
                colour: Color.new(255,0,0).to_u
            ))
        end
    end
    Discord.commands["status"] = ->status(Discord::Message)
end