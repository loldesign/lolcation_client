require "lolcation_client/version"

module LolcationClient
  autoload :Interceptor,      "lolcation_client/interceptor"
  autoload :Configurations,   "lolcation_client/configurations"
  autoload :CustomFields,     "lolcation_client/custom_fields"
  autoload :NearIn,           "lolcation_client/near_in"

  def self.extended(base)
    base.include LolcationClient::Interceptor
    base.extend  LolcationClient::CustomFields
    base.extend  LolcationClient::NearIn
  end
end
