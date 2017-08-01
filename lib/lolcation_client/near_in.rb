require "faraday"
require_relative "configurations"

module LolcationClient
  module NearIn
    include LolcationClient::Configurations

    def near_in(options = {})
      raise ArgumentError, 'Latitude and Longitude is required' unless options[:latitude].present? || options[:longitude].present?

      process(do_post(options), options)
    end

    def process(response, options)
      json = JSON.parse(response.body, object_class: OpenStruct)

      list = json['localizations']

      return list.map(&:objectId) if options[:only_ids]

      list
    end

    private

    def do_post(options = {})
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: "#{url}/near-me")
      conn.post do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = options.to_json
      end
    end
  end
end
