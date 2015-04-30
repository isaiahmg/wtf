require 'yaml'

class Configuration
  def self.load_options_from_file_or_use_defaults(file_path, default_options)
    new(file_path, default_options).load_or_create_config
  end
  
  def initialize(file_path, default_options)
    @file = file_path
    @options = default_options
  end
  
  def load_or_create_config
    config_file_exists? ? load_config_file : create_config_file
    @options
  end
  

private
  
  def config_file_exists?
    File.exists? @file
  end

  def create_config_file
    File.open(@file,'w') { |file| YAML::dump(@file,file) }
    STDERR.puts "Initialized configuration file in #{@file}"
  end

  def load_config_file
    config_options = YAML.load_file(@file)
    @options.merge!(config_options)
  end
end