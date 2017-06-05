module UserTimeZones
  module User
    extend ActiveSupport::Concern

    included do
      validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name).keys
    end

    #
    # Take time zone expressed as an offset.
    # Only really used
    #
    def time_zone_offset=(time_zone_offset)
      offset = "#{time_zone_offset}".to_i
      time_zone = ActiveSupport::TimeZone[offset].name
    end

  end
end
