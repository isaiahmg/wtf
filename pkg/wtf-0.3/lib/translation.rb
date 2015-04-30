class Translation
  def initialize(term, results = [])
    @term = term
    @results = [results].flatten
  end
  
  def term
    @term
  end
  
  def add_synonym(synonym)
    @results << synonym
  end
  
  def add_synonyms(synonym_array)
    (@results |= synonym_array).flatten!
  end
  
  def results
    @results
  end
end