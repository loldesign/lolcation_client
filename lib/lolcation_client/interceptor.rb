require "faraday"
require_relative "configurations"

module LolcationClient
  module Interceptor
    def self.included(model)
      model.send(:after_validation) do
        if self.lolcation_id.present?
          response = patch_on_lolcation_server
        else
          response = post_on_lolcation_server
        end

        parsed_response = JSON.parse(response.body)
        if parsed_response["error"]
          self.errors.add(:base, parsed_response["error"])
          false
        elsif parsed_response['localization']
          self.lolcation_id = parsed_response["localization"]["objectId"]
        else
          parsed_response.map {|error, message| self.errors.add("lolcation_#{error}", message[0])}
          false
        end
      end
    end

    private

    def configs
      Rails.application.config_for(:lolcation)
    end

    def token
      configs["token"]
    end

    def custom_fields
      self.class.try(:lolcation_custom_fields) || []
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

    def prepare_object_to_post
      {
        localization: {
          latitude: self.try(:lolcation_latitude),
          longitude: self.lolcation_longitude,
          name: self.try(:lolcation_name),
          address_street: self.lolcation_address_street,
          address_neighborhood: self.lolcation_address_neighborhood,
          address_city: self.lolcation_address_city,
          address_state: self.lolcation_address_state,
          address_number: self.lolcation_address_number,
          custom_fields: set_custom_fields
        },
        env: Rails.env || "development"
      }
    end

    def post_on_lolcation_server
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: url)
      conn.post do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = prepare_object_to_post.to_json
      end
    end

    def patch_on_lolcation_server
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: "#{url}#{self.lolcation_id}")
      conn.put do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = prepare_object_to_post.to_json
      end
    end
  end
end
