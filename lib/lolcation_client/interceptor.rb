require 'faraday'
require_relative 'configurations'

module LolcationClient
  module Interceptor
    def self.included(model)
      model.send(:before_save) do
        @custom_fields = set_custom_fields
        response = send_to_lolcation_server

        # DO STUFF WIP

        # After create on parse, should save lolcation_id on BD
      end
    end

    private

    def token
      configs['token']
    end

    def custom_fields
      self.try(:lolcation_custom_fields) || configs['custom_fields']
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

    def configs
      Rails.application.config_for(:lolcation)
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
      {localization: {latitude: self.latitude, longitude: self.longitude, name: self.name, custom_fields: set_custom_fields}}
    end
  end
end
