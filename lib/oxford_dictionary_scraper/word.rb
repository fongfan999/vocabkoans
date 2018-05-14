module OxfordDictionaryScraper
  class Word
    attr_reader :doc, :word

    def initialize(word, link)
      @doc  = Nokogiri::HTML(open(link))
      @word = word
    end

    def data_hash
      {
        word:       word,
        word_class: get_word_class,
        ipa:        get_ipa,
        sense:      get_definition_include_examples
      }
    end

    private

    def get_word_class
      doc.search('.webtop-g .pos').text
    end

    def get_ipa
      content = doc.search(".pron-gs.ei-g .pron-g[geo='n_am'] span.phon").first
      content.present? ? content.text.gsub('NAmE/', '').chomp('/') : ''
    end

    def get_definition_include_examples
      sn_gs_li = doc.search('.sn-gs .sn-g')

      definition_include_examples = []

      sn_gs_li.each do |div|
        definition_value = div.search('.def').text
        example_divs     = div.search('.x-gs .x-g .x')
        examples         = example_divs.map { |div| div.text }
        definition_include_examples << { definition: definition_value, examples: examples }
      end

      definition_include_examples
    end
  end
end
