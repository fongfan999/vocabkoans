require 'nokogiri'
require 'open-uri'
require 'oxford_dictionary_scraper.rb'
require 'oxford_words_importer.rb'

namespace :scraper do
  desc "TODO"
  task :scraping_and_import_3000_oxford_words => :environment do
    start_time   = Time.current.to_i
    scraped_data = OxfordDictionaryScraper.new.scraping

    File.write('lib/data/3000_words.json', scraped_data.to_json)

    importer = OxfordWordsImporter.new
    importer.import

    puts "Scraping Successfully in #{Time.current.to_i - start_time}"
  end
end
