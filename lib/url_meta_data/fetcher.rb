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
      begin
        HTTPClient.get(url).body
      rescue HTTPClient::TooManyRedirects
        ''
      end
    end
  end
end
