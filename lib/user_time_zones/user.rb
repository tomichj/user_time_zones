require 'active_support/time'

module UserTimeZones
  module User
    extend ActiveSupport::Concern

    included do
      validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.all.map{ |tz| tz.tzinfo.name }
    end

    #
    # Take time zone expressed as an offset.
    # Only really used
    #
    def time_zone_offset=(time_zone_offset)
      offset = "#{time_zone_offset}".to_i
      time_zone = ActiveSupport::TimeZone[offset].name
    end

    def time_zone_offset
      # return nil if time_zone.nil?
      nil
    end

  end
end
