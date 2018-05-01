module OxfordDictionaryScraper
  class Scraper
    def initialize; end

    def scraping
      first_chars = ['A-B', 'C-D', 'E-G', 'H-K', 'L-N', 'O-P', 'Q-R', 'S', 'T', 'U-Z']
      result = []
      first_chars.each do |first_char|
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts "Start scraping #{first_char}"

        doc = Nokogiri::HTML(open(oxford_3000_url + first_char))

        page = 1
        while doc.search('.paging_links li').last.values.first != 'activepage'
          doc        = Nokogiri::HTML(open(oxford_3000_url + first_char + "/?page=#{page}"))
          entry_list = doc.search('#entrylist1 .result-list1 li a')

          entry_list.each do |entry|
            word      = entry.text
            link      = entry.values.first
            result << OxfordDictionaryScraper::Word.new(word, link).data_hash
            puts word
          end

          puts "Complete Page #{page}"

          page += 1
        end
        puts "Complete #{first_char}!!!"
      end
      result
    end

    private

    def oxford_3000_url
      'https://www.oxfordlearnersdictionaries.com/wordlist/american_english/oxford3000/Oxford3000_'
    end
  end
end
