require 'nokogiri'
require 'open-uri'
require 'oxford_dictionary_scraper/scraper.rb'
require 'oxford_dictionary_scraper/word.rb'
require 'oxford_dictionary_scraper/importer.rb'

namespace :oxford_3000_words_scraper do
  desc "Scraping 3000 words from Oxford Dictionary"
  task :scrap => :environment do
    start_time   = Time.current.to_i
    scraped_data = OxfordDictionaryScraper::Scraper.new.scraping

    File.write('lib/data/3000_words.json', scraped_data.to_json)

    puts "Scrap Successfully in #{Time.current.to_i - start_time}s"
  end

  task :import => :environment do
    start_time   = Time.current.to_i
    importer = OxfordDictionaryScraper::Importer.new
    importer.import
    puts "Import Successfully in #{Time.current.to_i - start_time}s"
  end
end
