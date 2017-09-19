class Place < ApplicationRecord
	extend LolcationClient

	lolcation_custom_fields :active
end

# ---
# WITH ADDRESS
# ---

# place = Place.create(
# 	lolcation_name: 'caso do edu e da shi',
# 	lolcation_address_street: 'rua dos alpes',
# 	lolcation_address_neighborhood: 'cambuci',
# 	lolcation_address_city: 'sao paulo',
# 	lolcation_address_state: 'sp',
# 	lolcation_address_number: '120',
# 	lolcation_address_zipcode: '01520-030',
# )

# ---
# WITH LAT & LGN
# ---

# place = Place.create(
# 	lolcation_latitude: -23.5659256,
# 	lolcation_longitude: -46.6274346,
#   lolcation_name: 'Loldesign'
# )

# Place.near_in(latitude: '-23.5659256', longitude: '-46.6274346', distance: '0m')
