require "faraday"
require_relative "configurations"

module LolcationClient
  module NearIn
    include LolcationClient::Configurations

    def near_in(options = {})
      raise ArgumentError, 'Latitude and Longitude is required' unless options[:latitude].present? || options[:longitude].present?
      raise ArgumentError, 'Distance must be grater than 0'     if     options[:distance] =~ /\A0/

      process(do_post(options.merge(sandbox: sandbox?)), options)
    end

    def process(response, options)
      json = JSON.parse(response.body, object_class: OpenStruct)

      list = json['localizations']

      return list.map{|item| item.id.to_i} if options[:only_ids]

      list
    end

    private

    def do_post(options = {})
      conn = Faraday.new(url: "#{service_url}/near-me")
      conn.post do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = options.to_json
      end
    end
  end
end
