module LolcationClient
  module Configurations
    def configs
      Rails.application.config_for(:lolcation)
    end

    def service_url
      "#{configs['servie_url']}/api/v1/localizations"
    end

    def token
      configs["token"]
    end

    def sandbox?
      configs["sandbox"] || false
    end
  end
end
