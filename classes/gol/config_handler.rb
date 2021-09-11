require "json-schema"
require "json"

class ConfigHandler
  attr_accessor :schema_path, :config_path, :config

  def initialize
    @schema_path= 'schemas/gol_config_schema.json'
    @config_path= 'config/gol_config.json'

    @config= {
      "rows"=> 8,
      "columns"=> 8,
      "initial_alive_cells"=> [
        {
          "x"=> 0,
          "y"=> 0
        }
      ]
    }
  end

  def parseAndValidateConfig
    file = open(@config_path)
    json = file.read
    parsed = JSON.parse(json)
    JSON::Validator.validate!(@schema_path, parsed)
    @config = parsed
  end

end