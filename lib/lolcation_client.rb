require "lolcation_client/version"

module LolcationClient
  autoload :Interceptor,      "lolcation_client/interceptor"
  autoload :Configurations,   "lolcation_client/configurations"

  def self.extended(base)
    base.include LolcationClient::Interceptor
  end
end
