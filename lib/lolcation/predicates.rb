module Lolcation
  class Predicates
    #  class Localization
    #    extend Lolcation
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
