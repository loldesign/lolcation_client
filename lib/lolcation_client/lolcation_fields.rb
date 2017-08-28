module LolcationClient
  module LolcationFields
    def lolcation_fields(options = {})
      self.class_eval do
        before_validation do
          fields = [
            :latitude,
            :longitude,
            :name,
            :address_street,
            :address_neighborhood,
            :address_city,
            :address_state,
            :address_number,
            :address_zipcode,
          ]

          fields.each do |field|
            self.send("lolcation_#{field}=", self.send(options[field] || "lolcation_#{field}"))
          end

          true
        end
      end
    end
  end
end
