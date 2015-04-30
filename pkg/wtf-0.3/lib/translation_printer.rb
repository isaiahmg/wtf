class TranslationPrinter
  
  def initialize(options)
    @options = options
  end
  
  def print(translations)
    @translations = translations
    
    set_delimiter_if_format_specified
    
    @translations.each do |translation|
      results = translation.results.join(@options[:joiner])
      terms = [translation.term, results]
      terms.reverse! if @options[:switch]
      puts "#{terms[0]}#{@options[:delimiter]}#{terms[1]}"
    end
  end
  
  
private
  
  def set_delimiter_if_format_specified
    if @options[:format].nil?
      @options[:format] = 'pretty' if STDOUT.tty?
    end

    if @options[:format] == 'pretty'
      @options[:delimiter] = ' - '
    end
  end
end