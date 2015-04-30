class TranslationResponseParser
  TRANSLATION_TYPES = ['PrincipalTranslations', 'Entries']
  
  def initialize(response_hash)
    @translations = []
    @response = response_hash
  end
  
  def translations
    @translations
  end
  
  def self.build_translations_from_json(response_hash)
    new(response_hash).build_translations
  end
  
  def build_translations
    @response.each do |key, definitions|
      if key.start_with? 'term'
        translation_references = find_translation_references(definitions)
        add_translations_from_references(translation_references)
      end
    end
    @translations
  end
  

private
  
  def find_translation_references(definitions)
    references = []
    TRANSLATION_TYPES.each do |translation_type|
      if definitions.has_key? translation_type
        references << definitions[translation_type]
      end
    end
    references
  end
  
  def add_translations_from_references(references)
    references.each do |reference_hash|
      reference_hash.each do |reference_number, reference|
        new_term = extract_term(reference)
        new_term_tranlsations = extract_translations(reference)
        add_new_translations(new_term, new_term_tranlsations)
      end
    end
  end
  
  def extract_term(translation_object)
    translation_object['OriginalTerm']['term'].strip
  end
  
  def extract_translations(translation_object)
    translations = []
    translation_object.each do |key, definition|
      if key.end_with? 'Translation'
        translations |= definition['term'].split(',').map{ |t| t.strip }
      end
    end
    translations
  end
  
  def add_new_translations(term, translations)
    if existing_translation = find_term_in_translations_array(term)
      existing_translation.add_synonyms(translations)
    else
      @translations << Translation.new(term, translations)
    end
  end
    
  def find_term_in_translations_array(term)
    @translations.each do |translation|
      return translation if translation.term == term
    end
    false
  end
end