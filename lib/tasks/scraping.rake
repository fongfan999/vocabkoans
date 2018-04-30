require 'nokogiri'
require 'open-uri'

namespace :scraping do
  desc "TODO"
  task :run => :environment do
    words = []

    words = File.read('lib/scraper/source_3k_words.txt').split("\n")

    result = []
    words.first(10).each do |word|
      doc = Nokogiri::HTML(open('https://www.oxfordlearnersdictionaries.com/definition/english/' + word))

      word_class = doc.search('.webtop-g .pos').text

      sn_gs_li = doc.search('.sn-gs li')
      definition_divs = []
      sn_gs_li.each do |li|
        definition_divs << li if li.search('.sym_first').present?
      end

      definition_include_examples = []

      definition_divs.each do |div|
        definition_value = div.search('.def').text
        example_divs = div.search('.x-gs .x-g .x')
        examples = example_divs.map { |div| div.text }
        definition_include_examples << { definition: definition_value, examples: examples }
      end

      res = { word: word.strip, word_class: word_class, sense: definition_include_examples }

      result << res
    end

    File.write('lib/result', result.to_json)

    my_file = File.read('lib/result')
    data_hash = JSON.parse(my_file)
    byebug
  end
end
