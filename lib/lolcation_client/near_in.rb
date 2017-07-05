require "faraday"
require_relative "configurations"

module LolcationClient
  module NearIn
    include LolcationClient::Configurations

    def near_in(options = {})
      raise ArgumentError, 'You must pass latitude and longitude as params' unless options[:latitude] || options[:longitude]
      response = grab_objects(options)
      parse_response = JSON.parse(response.body)
      parse_response['localizations']
    end

    private

    def grab_objects(options = {})
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