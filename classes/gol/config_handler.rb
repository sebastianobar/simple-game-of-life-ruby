require "json-schema"
require "json"

class ConfigHandler
  attr_accessor :schema_path, :json_config_path, :custom_config_path, :config

  def initialize
    @schema_path= 'schemas/gol_config_schema.json'
    @json_config_path= 'config/gol_config.json'
    @custom_config_path= 'config/custom_config'

    @config= {
      "rows"=> 8,
      "columns"=> 8,
      "actual_gen"=> 0,
      "initial_alive_cells"=> [
        {
          "x"=> 0,
          "y"=> 0
        }
      ]
    }
  end

  def parseAndValidateJsonConfig
    file = File.open(@json_config_path)
    json = file.read
    file.close
    parsed = JSON.parse(json)
    JSON::Validator.validate!(@schema_path, parsed)
    @config = parsed
  end


  def parseAndValidateCustomConfig
    file = File.open(custom_config_path)
    file_lines = file.readlines.map(&:chomp)
    file.close
    if !/Generation \d+:/.match?(file_lines[0])
      puts 'errorre cazz'
      raise StandardError.new("Invalid Config")
    elsif !/\d+ \d+/.match?(file_lines[1])
      puts 'errorre cazz'
      raise StandardError.new("Invalid Config")
    end

    actual_gen=/\d+/.match(file_lines[0]).to_s.to_i
    rows=/\d+/.match(file_lines[1], 0).to_s.to_i
    columns=/\d+/.match(file_lines[1], 1).to_s.to_i
    initial_alive_cells = []
    rows.times do |row|
      if !file_lines[row+2]
        raise StandardError.new("Invalid Config")
      end
      columns.times do |column|
        if !file_lines[row+2][0]
          raise StandardError.new("Invalid Config")
        end
        if "*" == file_lines[row+2][column]
          initial_alive_cells.push({ "x"=> column, "y"=> row})
        end
      end
    end
    @config["actual_gen"] = actual_gen
    @config["rows"] = rows
    @config["columns"] = columns
    @config["initial_alive_cells"] = initial_alive_cells
    puts @config
  end

end