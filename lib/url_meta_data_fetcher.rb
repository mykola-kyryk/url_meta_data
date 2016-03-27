require "url_meta_data_fetcher/version"
require 'faraday'
require 'faraday_middleware'

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
      response = connection.get(url)
      response.body
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.use FaradayMiddleware::FollowRedirects
      end
    end
  end

end
