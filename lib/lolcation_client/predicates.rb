module LolcationClient
  class Predicates
    #  class Localization
    #    extend lolcation_client
    #    lolcalize latitude: :custom_latitude, longitude: :custom_longitude
    #    or even
    #    lolcalize! (this should assume that is the standards names)
    #  end

    def lolcalize(options = {})
    end

    def lolcalize!
      super({latitude: :latitude, longitude: :longitude})
    end
  end
end
