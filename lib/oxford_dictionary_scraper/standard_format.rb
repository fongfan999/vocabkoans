module OxfordDictionaryScraper
  class StandardFormat
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def avoicd_coincident_chars
      str.gsub('(=', '( =')
    end
  end
end
