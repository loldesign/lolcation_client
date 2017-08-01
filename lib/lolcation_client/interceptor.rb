require "faraday"
require_relative "configurations"

module LolcationClient
  module Interceptor
    include LolcationClient::Configurations

    def self.included(model)
      model.send(:after_validation) do
        if self.persisted?
          response = update_on_lolcation_server
        else
          response = create_on_lolcation_server
        end

        json = JSON.parse(response.body, object_class: OpenStruct)

        if json.error.present?
          self.errors.add(:base, json.error)
          false
        elsif json.localization.present?
          self.lolcation_id = json.localization.id
          self.lolcation_latitude = json.localization.latitude
          self.lolcation_longitude = json.localization.longitude
        else
          json.map {|error, message| self.errors.add("lolcation_#{error}", message[0])}
          false
        end
      end
    end

    private

    def custom_fields
      self.class.try(:lolcation_custom_fields) || []
    end

    def build_custom_fields
      attributes = custom_fields.map {|attribute| {attribute => self.try(attribute)}}
      hash       = {}

      attributes.each do |attribute|
        attribute.each do |key, value|
          hash[key] = value
        end
      end

      hash
    end

    def build_params
      {
        localization: {
          latitude:             self.try(:lolcation_latitude),
          longitude:            self.try(:lolcation_longitude),
          name:                 self.try(:lolcation_name),
          address_street:       self.try(:lolcation_address_street),
          address_neighborhood: self.try(:lolcation_address_neighborhood),
          address_city:         self.try(:lolcation_address_city),
          address_state:        self.try(:lolcation_address_state),
          address_number:       self.try(:lolcation_address_number),
          address_zipcode:      self.try(:lolcation_address_zipcode),
          #custom_fields:        build_custom_fields
        },
        sandbox: sandbox?
      }.to_json
    end

    def create_on_lolcation_server
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: url)
      conn.post do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = build_params
      end
    end

    def update_on_lolcation_server
      url = LolcationClient::Configurations::URL
      conn = Faraday.new(url: "#{url}/#{self.lolcation_id}")
      conn.put do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = build_params
      end
    end
  end
end
