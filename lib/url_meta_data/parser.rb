require 'nokogiri'

module UrlMetaData
  class Parser
    private_class_method :new

    def self.parse(document)
      new(document).send(:parse)
    end

    private

    attr_reader :document

    def initialize(document)
      @document = Nokogiri::HTML.parse(document) do |config|
        config.options = Nokogiri::XML::ParseOptions::DEFAULT_HTML | Nokogiri::XML::ParseOptions::NONET
      end
    end

    def parse
      {
        title: get_page_title,
        keywords: get_meta_keywords,
        description: get_meta_description
      }
    end

    def get_page_title
      document.css('title').first&.content
    end

    def get_meta_keywords
      get_meta_content(name: 'keywords')
    end

    def get_meta_description
      get_meta_content(name: 'description')
    end

    def get_meta_content(name:)
      document.css("meta[name='#{name}']").first&.attribute('content')&.value
    end
  end
end
