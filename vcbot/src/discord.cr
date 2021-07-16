require "../lib/discordcr/src/discordcr"
require "./jsonreader"
require "./commands/*"

# Import prefix from json (Prefix is defined as an export in jsonreader.cr)
prefix = JSONReader.test.prefix

# Refer to one of the existing commands in ./commands/ to see how to add a command
module Discord
  class_getter client : Discord::Client {Discord::Client.new(token: "Bot #{JSONReader.test.token}")}
  class_getter commands : Hash(String, Proc(Discord::Message, Nil)) { Hash(String, Proc(Discord::Message, Nil)).new }
  class_getter cmdinfo : Hash(String, String) { Hash(String, String).new }
end

# This event will only be triggered with server member intents enabled
Discord.client.on_guild_member_add do |payload|
  Discord.client.add_guild_member_role(guild_id: 850173983806849034.to_u64, user_id: payload.user.id, role_id: 861485216375242772.to_u64)
end

Discord.client.on_message_create do |payload|

  if payload.author.id != 856084704725303297.to_u64

    if payload.content.starts_with?(prefix)
      args = payload.content.split()
      cmdname = args[0].gsub(prefix, "")

      if Discord.commands.has_key?(cmdname)

        if (cmdname == "example") # Makes sure the example command file does not run.
          next
        end

        puts "\nCommand in cmd array!\nRunning command: #{cmdname}\nRan by #{payload.author.username} on server-id #{payload.guild_id}\n "

        spawn name: "cmd" do
            Discord.commands[cmdname].call(payload)
        end

      else
        puts "Command not in cmd array!  Was it properly added?"
        next
      end
    end
  end
end

spawn name: "discord" do
    Discord.client.run
end