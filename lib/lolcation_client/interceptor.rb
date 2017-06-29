require 'faraday'
require_relative 'configurations'

module LolcationClient
  module Interceptor
    def self.included(model)
      model.send(:before_save) do
        response = send_to_lolcation_server
        parsed_response = JSON.parse(response.body)
        self.lolcation_id = parsed_response['localization']['objectId']
      end
    end

    private

    def configs
      Rails.application.config_for(:lolcation)
    end

    def token
      configs['token']
    end

    def custom_fields
      self.try(:lolcation_custom_fields)
    end

    def set_custom_fields
      attributes = custom_fields.map {|attribute| {attribute => self.try(attribute)}}
      hash = {}
      attributes.each do |attribute|
        attribute.each do |key, value|
          hash[key] = value
        end
      end

      hash
    end

    def send_to_lolcation_server
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: url)
      conn.headers.merge!({"X-Token" => token})
      conn.post do |r|
        r.headers['Content-Type'] = 'application/json'
        r.body = prepare_object_to_post.to_json
      end
    end

    def prepare_object_to_post
      {
        localization: {
          latitude: self.lolcation_latitude,
          longitude: self.lolcation_longitude,
          name: self.lolcation_name,
          address_street: self.lolcation_address_street,
          address_neighborhood: self.lolcation_address_neighborhood,
          address_city: self.lolcation_address_city,
          address_state: self.lolcation_address_state,
          address_number: self.lolcation_address_number,
          custom_fields: set_custom_fields
        }
      }
    end
  end
end
