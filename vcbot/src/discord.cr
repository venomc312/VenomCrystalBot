# This simple example bot replies to every "!ping" message with "Pong!".


require "../lib/discordcr/src/discordcr"
require "./jsonreader"
require "./commands/*"

# Import prefix from json (Prefix is defined as an export in jsonreader.cr)
prefix = JSONReader.test.prefix

# Command name must be the same as the module name for this command handler to work!
module Discord
  class_getter client : Discord::Client {Discord::Client.new(token: "Bot #{JSONReader.test.token}")}
  class_getter commands : Hash(String, Proc(Discord::Message, Nil)) { Hash(String, Proc(Discord::Message, Nil)).new }
end

# This event isn't being triggered and I don't know why :(
Discord.client.on_guild_member_add do |payload|
    puts Discord.client.add_guild_member_role(guild_id: 850173983806849034.to_u64, user_id: payload.user.id, role_id: 861485216375242772.to_u64)
end

Discord.client.on_message_create do |payload|

  if payload.content.starts_with?(prefix)
    args = payload.content.split()
    cmdname = args[0].gsub(prefix, "")

    if Discord.commands.has_key?(cmdname)
      puts "Command in cmd array!"
      puts "Running command: #{cmdname}"

      spawn name: "cmd" do
          Discord.commands[cmdname].call(payload)
      end

    else
      puts "Command not in cmd array!  Was it properly added?"
      next
    end

    # if args[0].includes?("test")
    #  client.create_message(payload.channel_id, "Response")
    #end

    # if args[0].includes?("ping")
    #  m = client.create_message(payload.channel_id, "Pong!")
    #  time = Time.utc - payload.timestamp
    #  client.edit_message(m.channel_id, m.id, "Pong! #{time.total_milliseconds} ms.")
    #end

    pp args
  end

end

spawn name: "discord" do
    Discord.client.run
end