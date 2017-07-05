module LolcationClient
  module Configurations
    URL = "https://lolcation-service.loldesign.com.br/api/v1/localizations"

    def configs
      Rails.application.config_for(:lolcation)
    end

    def token
      configs["token"]
    end

    def sandbox?
      configs["sandbox"] || false
    end
  end
end
