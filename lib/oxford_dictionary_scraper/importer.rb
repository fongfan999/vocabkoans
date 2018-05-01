module OxfordDictionaryScraper
  class Importer
    def initialize; end

    def import
      data_hash = get_data_hash
      Vocabulary.create(data_hash)
    end

    private

    def get_data_hash
      JSON.parse(File.read('lib/data/3000_words.json'))
    end
  end
end
