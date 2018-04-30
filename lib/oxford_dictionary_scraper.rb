class OxfordDictionaryScraper
  def initialize; end

  def scraping
    words = read_file
    result = []
    words.each_with_index do |word, idx|
      sleep 10 if idx % 100 == 0

      doc = Nokogiri::HTML(open('https://www.oxfordlearnersdictionaries.com/definition/english/' + word))

      word_class                  = get_word_class(doc)
      sn_gs_li                    = get_sn_gs_li(doc)
      definition_include_examples = get_definition_include_examples(sn_gs_li)

      result << { word: word, word_class: word_class, sense: definition_include_examples }
    end

    result
  end

  private

  def read_file
    File.read('lib/scraper/source_3k_words.txt').split("\n")
  end

  def get_word_class(doc)
    doc.search('.webtop-g .pos').text
  end

  def get_sn_gs_li(doc)
    doc.search('.sn-gs .sn-g')
  end

  def get_definition_include_examples(sn_gs_li)
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
