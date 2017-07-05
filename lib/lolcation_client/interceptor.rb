require "faraday"
require_relative "configurations"

module LolcationClient
  module Interceptor
    include LolcationClient::Configurations

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
          self.lolcation_latitude = parsed_response["localization"]["latitude"]
          self.lolcation_longitude = parsed_response["localization"]["longitude"]
        else
          parsed_response.map {|error, message| self.errors.add("lolcation_#{error}", message[0])}
          false
        end
      end
    end

    private

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
          longitude: self.try(:lolcation_longitude),
          name: self.try(:lolcation_name),
          address_street: self.try(:lolcation_address_street),
          address_neighborhood: self.try(:lolcation_address_neighborhood),
          address_city: self.try(:lolcation_address_city),
          address_state: self.try(:lolcation_address_state),
          address_number: self.try(:lolcation_address_number),
          custom_fields: set_custom_fields
        },
        sandbox: sandbox?
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
      conn = Faraday.new(url: "#{url}/#{self.lolcation_id}")
      conn.put do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = prepare_object_to_post.to_json
      end
    end
  end
end
