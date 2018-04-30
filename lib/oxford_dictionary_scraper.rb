class OxfordDictionaryScraper
  def initialize; end

  def scraping
    first_chars = ['A-B', 'C-D', 'E-G', 'H-K', 'L-N', 'O-P', 'Q-R', 'S', 'T', 'U-Z']
    result = []
    first_chars.each do |first_char|
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
      puts "Start scraping #{first_char}"
      doc = Nokogiri::HTML(open('https://www.oxfordlearnersdictionaries.com/wordlist/american_english/oxford3000/Oxford3000_' + first_char))
      page = 1
      while doc.search('.paging_links li').last.values.first != 'activepage'
        doc = Nokogiri::HTML(open('https://www.oxfordlearnersdictionaries.com/wordlist/american_english/oxford3000/Oxford3000_' + first_char + '/?page=' + page.to_s))
        entry_list = doc.search('#entrylist1 .result-list1 li a')
        entry_list.each do |entry|
          link = entry.values.first
          word_doc = Nokogiri::HTML(open(link))

          word_class                  = get_word_class(word_doc)
          sn_gs_li                    = get_sn_gs_li(word_doc)
          definition_include_examples = get_definition_include_examples(sn_gs_li)
          result << { word: entry.text, word_class: word_class, sense: definition_include_examples }
        end
        puts 'Complete Page ' + page.to_s
        page += 1
      end
      puts "Complete #{first_char}!!!"
    end
    result
  end

  private

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
