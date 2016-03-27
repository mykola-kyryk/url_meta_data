require "url_meta_data_fetcher/version"

module UrlMetaData

  class Fetcher
    private_class_method :new

    attr_reader :url

    def self.fetch(url)
      new(url).send(:fetch)
    end

    private

    def initialize(url)
      @url = url
    end

    def fetch
      # Process url
    end
  end

end
