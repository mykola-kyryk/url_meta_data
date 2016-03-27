require 'net/http'

module UrlMetaData
  class HTTPClient
    MAX_REDIRECTS = 5
    class TooManyRedirects < StandardError
    end

    private_class_method :new

    def self.get(url)
      new.get(url)
    end

    def get(url)
      perform_get(url, MAX_REDIRECTS)
    end

    private

    def perform_get(url, redirect_count)
      raise TooManyRedirects, "More than #{MAX_REDIRECTS} redirects  encountered" if redirect_count == 0

      @request_url = url
      response = Net::HTTP.get_response(uri)

      if redirect_encountered?(response)
        perform_get(response.header['location'], redirect_count - 1)
      else
        response
      end
    end

    def redirect_encountered?(response)
      response.is_a?(Net::HTTPRedirection) && response.header.key?('location')
    end

    def uri
      URI(@request_url)
    end
  end
end
