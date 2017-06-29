module LolcationClient
  module CustomFields
    def lolcation_custom_fields(*params)
      @lolcation_custom_fields ||= params
    end
  end
end
