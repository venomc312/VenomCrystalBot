require "http/server"

require "./jsonreader"

ws_handler = HTTP::WebSocketHandler.new do |socket, ctx|
  puts "Socket opened #{ctx.request.path}"
  socket.on_message do |message|
    socket.send JSONReader.test.to_json
  end
  socket.on_close do
    puts "Socket closed"
  end
end

server = HTTP::Server.new([ws_handler])
address = server.bind_tcp JSONReader.test.wsadd, JSONReader.test.wsport
puts "Listening on ws://#{address}"

spawn name: "websocket" do
    server.listen
end