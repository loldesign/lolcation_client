module LolcationClient
  module Configurations
    API = "/api/v1/localizations"
    URL = Rails.env.development?
            ? "http://localhost:8000#{API}" 
            : "https://lolcation-service.loldesign.com.br#{API}"

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
