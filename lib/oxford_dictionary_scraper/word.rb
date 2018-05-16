module OxfordDictionaryScraper
  class Word
    attr_reader :doc, :word

    def initialize(word, link)
      @doc  = Nokogiri::HTML(open(link))
      @word = word
    end

    def data_hash
      {
        word:       normalize_word,
        word_class: get_word_class,
        ipa:        get_ipa,
        sense:      get_definition_include_examples
      }
    end

    private

    def normalize_word
      word.scan(/\d+/).empty? ? word : StandardFormat.new(word).remove_suffix
    end

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

      sn_gs_li.each do |li|
        definition_value    = li.search('.def').text
        stardard_definition = StandardFormat.new(definition_value).avoid_coincident_chars
        example_divs        = li.search('.x-gs .x-g .x')
        examples            = example_divs.map { |div| StandardFormat.new(div.text).avoid_coincident_chars }
        definition_include_examples << { definition: stardard_definition, examples: examples }
      end

      definition_include_examples
    end
  end
end
