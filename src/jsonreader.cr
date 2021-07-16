record Config, token : String, prefix : String do
    include JSON::Serializable
  end
  
  module JSONReader
    class_getter test : Config { File.open("./config.json") { |file| Config.from_json file } }
  end

  # If you want to add things to the config file you should define the variables here, this will make them global to the program.
  # Take the above example and compare it to these lines to learn how to add variables

  # record Config, newvariable : Int32, token : String, prefix : String do
  #   include JSON::Serializable
  # end
  
  # The variables should be added onto the code above and not duplicated.
