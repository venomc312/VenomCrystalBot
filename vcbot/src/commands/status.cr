require "../../lib/discordcr/src/discordcr"
require "../color"
require "../discord"
require "json"
require "http/client"

module Commands
    extend self
    def status(payload) : Nil
        response = HTTP::Client.get "http://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001?addr=69.30.205.147&format=json"
        response1 = HTTP::Client.get "https://mcapi.us/server/status?ip=mc1.venomc312.com"
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

        if response1.body.includes?("true")
            json = JSON.parse(response1.body)
            players = json["players"]

            Discord.client.create_message(payload.channel_id, "", Discord::Embed.new(
                title: "Venom's Minecraft Server",
                description: "Players: " + players["now"].to_s + "/" + players["max"].to_s,
                timestamp: Time.utc,
                colour: Color.new(0,255,81).to_u
            ))
        else
            Discord.client.create_message(payload.channel_id, "", Discord::Embed.new(
                title: "Venom's Minecraft Server",
                description: "Offline",
                timestamp: Time.utc,
                colour: Color.new(255,0,0).to_u
            ))
        end
    end
    Discord.cmdinfo["status"] = "Replies with the status of all current registered servers"
    Discord.commands["status"] = ->status(Discord::Message)
end