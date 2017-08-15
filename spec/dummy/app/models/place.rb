class Place < ApplicationRecord
	extend LolcationClient

	lolcation_custom_fields :active
end


# place = Place.create(
# 	lolcation_name: 'caso do edu e da shi',
# 	lolcation_address_street: 'rua dos alpes',
# 	lolcation_address_neighborhood: 'cambuci',
# 	lolcation_address_city: 'sao paulo',
# 	lolcation_address_state: 'sp',
# 	lolcation_address_number: '120',
# 	lolcation_address_zipcode: '01520-030',
# )
