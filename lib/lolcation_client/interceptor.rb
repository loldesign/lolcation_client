require 'httparty'
require_relative 'configurations'

module LolcationClient
  module Interceptor
    def self.included(model)
      model.send(:before_save) do
        latitude, longitude = self.latitude, self.longitude
        custom_attributes = set_custom_attributes
        response = send_to_lolcation_server.parsed_response

        # DO STUFF WIP

        # After create on parse, should save lolcation_id on BD
      end
    end

    private

    def token
      configs['token']
    end

    def custom_attributes
      self.try(:lolcation_custom_attributes) || configs['custom_attributes']
    end

    def set_custom_attributes
      custom_attributes.map {|attribute| {attribute => self.try(attribute)}}
    end

    def configs
      Rails.application.config_for(:lolcation)
    end

    def send_to_lolcation_server
      url = LolcationClient::Configurations::URL
      headers = {headers: {"X-Token" => token}}
      body = {body: prepare_object_to_post}
      request_options = headers.merge(body)
      HTTParty.post(url, request_options)
    end

    def prepare_object_to_post
      {localization: {latitude: self.latitude, longitude: self.longitude, name: self.name}}
    end
  end
end
