require "faraday"
require_relative "configurations"

module LolcationClient
  module NearIn
    include LolcationClient::Configurations

    def near_in(options = {})
      raise ArgumentError, 'You must pass latitude and longitude as params' unless options[:latitude] || options[:longitude]

      parse_response(grab_objects(options), options)
    end

    def parse_response(response, options)
      json = JSON.parse(response.body, object_class: OpenStruct)

      list = json['localizations']

      return list.map(&:objectId) if options[:only_ids]

      list
    end

    private

    def grab_objects(options = {})
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: "#{url}/near-me")
      conn.post do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = options
      end
    end
  end
end
