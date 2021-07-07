record Config, token : String, prefix : String do
    include JSON::Serializable
  end
  
  module JSONReader
    class_getter test : Config { File.open("./config.json") { |file| Config.from_json file } }
  end