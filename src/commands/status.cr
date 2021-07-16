require "../../lib/discordcr/src/discordcr"
require "../color"
require "../discord"
require "json"
require "http/client"

module Commands
    extend self
    def status(payload) : Nil
        response = HTTP::Client.get "https://superstormchasing.net/server-content/a2s-status/status.php?ip=69.30.205.147:27015" # a2s Query (Garry's Mod Server)
        response1 = HTTP::Client.get "https://mcapi.us/server/status?ip=mc1.venomc312.com" # MC-Query API (Minecraft Server)
        if response.body.includes?("garrysmod")
            json = JSON.parse(response.body)
            Discord.client.create_message(payload.channel_id, "", Discord::Embed.new(
                title: "Venom's Train Build",
                description: "Players: " + json["Players"].to_s + "/" + json["MaxPlayers"].to_s + "\n\n_Ver. " + json["Version"].to_s + "_",
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

        # The API for this only caches every two minutes, the response will be delayed. (https://mcapi.us/server/status?ip=mc1.venomc312.com)
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