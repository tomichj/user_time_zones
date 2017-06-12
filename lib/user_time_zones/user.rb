require 'active_support/time'

module UserTimeZones
  module User
    extend ActiveSupport::Concern

    included do
      validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.all.map{ |tz| tz.name }
    end

    #
    # Take time zone expressed as an offset.
    # Only really used
    #
    def time_zone_offset=(time_zone_offset)
      offset = "#{time_zone_offset}".to_i
      self.time_zone = ActiveSupport::TimeZone[offset].name
    end

    def time_zone_offset
      return nil if time_zone.nil?
      tz ||= Time.find_zone! time_zone
      tz.utc_offset / 3600 unless (tz.nil? || tz.utc_offset.nil?)
    end

  end
end
