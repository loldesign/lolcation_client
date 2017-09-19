require "faraday"
require_relative "configurations"

module LolcationClient
  module Interceptor
    include LolcationClient::Configurations

    def self.included(model)
      model.send(:after_validation) do
        self.errors.add("lolcation_name", :blank) unless self.lolcation_name.present?

        if self.lolcation_address_street.present?
          self.errors.add("lolcation_address_neighborhood", :blank) unless self.lolcation_address_neighborhood.present?
          self.errors.add("lolcation_address_city"        , :blank) unless self.lolcation_address_city.present?
          self.errors.add("lolcation_address_state"       , :blank) unless self.lolcation_address_state.present?
          self.errors.add("lolcation_address_number"      , :blank) unless self.lolcation_address_number.present?
          self.errors.add("lolcation_address_zipcode"     , :blank) unless self.lolcation_address_zipcode.present?
        else
          self.errors.add("lolcation_latitude" , :blank)            unless self.lolcation_latitude.present?
          self.errors.add("lolcation_longitude", :blank)            unless self.lolcation_longitude.present?
        end
      end

      model.send(:after_save) do
        if self.lolcation_id.present?
          response = update_on_lolcation_server
        else
          response = create_on_lolcation_server
        end

        json = JSON.parse(response.body, object_class: OpenStruct)

        if json.success
          self.lolcation_id = json.id
          self.lolcation_latitude = json.latitude
          self.lolcation_longitude = json.longitude
          true
        else
          json.errors.collect{|error| self.errors.add("lolcation_#{error.field}", error.message)}

          false
        end
      end
    end

    private

    def custom_fields
      self.class.try(:lolcation_custom_fields) || []
    end

    def build_filter_fields
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
          filters:              build_filter_fields,
          sandbox:              sandbox?
        }
      }.to_json
    end

    def create_on_lolcation_server
      conn = Faraday.new(url: service_url)
      conn.post do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = build_params
      end
    end

    def update_on_lolcation_server
      conn = Faraday.new(url: "#{service_url}/#{self.lolcation_id}")
      conn.put do |r|
        r.headers["X-Token"] = token
        r.headers["Content-Type"] = "application/json"
        r.body = build_params
      end
    end
  end
end
