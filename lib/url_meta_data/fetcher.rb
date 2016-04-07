module UrlMetaData
  class Fetcher
    private_class_method :new

    def self.fetch(url)
      new(url).send(:fetch)
    end

    private

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def fetch
      Parser.parse(document)
    end

    def document
      begin
        HTTPClient.get(url).body
      rescue HTTPClient::TooManyRedirects, Timeout::Error, IOError, Errno::ECONNREFUSED, SocketError
        # too many redirects, resource not found, slow resource, invalid resource, etc
        ''
      end
    end
  end
end
