require 'optparse'

class TranslationOptionsParser
  FORMATS = ['pretty', 'csv']
  
  def initialize(default_options = {})
    @exit_status = 0
    @options = default_options
    @terms = []
    @parser
    define_options
  end
  
  def terms
    @terms
  end
  
  def exit_status
    @exit_status
  end
  
  def options
    @options
  end
  
  def parse!
    begin
      @parser.parse!
      
      if @options[:key].to_s.empty?
        STDERR.puts "error: you must provide an api key for wordreference.com
           (check your #{File.basename(CONFIG_FILE)} file in your home directory)\n"
        @exit_status |= 0b0100
        
      elsif !@options[:format].nil? && !FORMATS.include?(@options[:format])
        STDERR.puts "error: you must provide a valid output format\n"
        @exit_status |= 0b1000
        
      elsif ARGV.empty?
        STDERR.puts "Reading terms from stdin..."
        @terms = STDIN.readlines.map { |term| term.chomp }
        
      else
        ARGV.each { |term| @terms << term.chomp }
      end
  
      if @terms.empty? && @exit_status == 0
        STDERR.puts "error: you must supply a term to translate\n"
        @exit_status |= 0b0010
      end
  
      STDERR.puts "\n" + @parser.help if @exit_status != 0
      
      @terms
  
    rescue OptionParser::InvalidArgument => ex
      STDERR.puts ex.message
      STDERR.puts @parser
      @exit_status |= 0b0001
    end
  end
  
  def error?
    @exit_status != 0
  end

  
private
    
  def define_options
    @parser = OptionParser.new do |opts|
      executable_name = File.basename($PROGRAM_NAME)
      opts.banner = "#{WordTranslationFast::DESCRIPTION}\n\nUsage: #{executable_name} [options] term\n"
  
      # Program switches
      opts.on('-s', '--switch-order',
              'switch order in which term and translation are outputted') do
        @options[:switch] = true
      end
  
      # Program flags
      opts.on('--delimiter DELIMITER',
              'delimiter to use for csv file') do |delimiter|
        @options[:delimiter] = delimiter
      end
      opts.on('-d DICTIONARY', '--dictionary DICTIONARY',
              'translation dictionary to use') do |dictionary|
        @options[:dictionary] = dictionary
      end
      opts.on('--format FORMAT',
              'Format of the output (\'pretty\' for TTY, \'csv\' otherwise)') do |format|
        @options[:format] = format
      end
      opts.on('-j JOINER', '--joiner JOINER',
              'characters used to join multiple definitions') do |joiner|
        @options[:joiner] = joiner
      end
      opts.on('-k API_KEY', '--api-key API_KEY',
              'your wordreference.com api key') do |key|
        @options[:key] = key
      end
    end
  end
end