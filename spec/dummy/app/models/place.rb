class Place < ApplicationRecord
	extend LolcationClient

	lolcation_custom_fields :active
end
