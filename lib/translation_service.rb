require 'translation'
require 'translation_response_parser'
require 'net/http'
require 'json'

class TranslationService
  JSON_API_URL = 'http://api.wordreference.com/0.8/%s/json/%s/' # (in form http://api.wordreference.com/{api_version}/{API_key}/json/{dictionary}/)
  
  def initialize(api_key, dictionary)
    @api_key = api_key
    @dictionary = dictionary
    @translations = []
  end
  
  def translate(terms)
    fetch_each_term(terms)
    @translations
  end


private
  
  def fetch_each_term(terms)
    @uri = URI(sprintf(JSON_API_URL, @api_key, @dictionary))

    Net::HTTP.start(@uri.host, @uri.port) do |http|
      terms.each do |term|
        STDERR.puts "Translating \"#{term}\"..."
        response = request_translation_from_api(term, http)
        if response.is_a?(Net::HTTPSuccess)
          json_response = JSON.load(response.body)
          print_note_for_error_translating_word(term, json_response)
          print_redirect_url(term, json_response)
          @translations = TranslationResponseParser.build_translations_from_json(json_response)
        else
          STDERR.puts "error: failed to connect to wordreference.com\n"
          exit 0b0100
        end
      end
    end
  end
  
  def request_translation_from_api(term, http_connection)
    request = Net::HTTP::Get.new @uri.request_uri+URI::encode(term)
    http_connection.request request
  end
  
  def print_note_for_error_translating_word(term, json_response)
    puts term + ' - ' + json_response['Note'] if json_response.has_key? 'Error'
  end
  
  def print_redirect_url(term, json_response)
    puts term + ' - ' + json_response['URL'] if json_response.has_key? 'URL'
  end
end