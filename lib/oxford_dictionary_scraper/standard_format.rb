module OxfordDictionaryScraper
  class StandardFormat
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def avoid_coincident_chars
      str.gsub('(=', '( =')
    end

    def remove_suffix
      str.gsub(/[ 0-9]\w+/, '')
    end
  end
end
