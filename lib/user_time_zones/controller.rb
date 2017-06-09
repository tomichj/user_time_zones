module UserTimeZones
  module Controller
    extend ActiveSupport::Concern

    included do
      around_action :user_time_zone, if: :current_user
    end

    protected

    # Use this time zone for the duration of this controller action
    def user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block) unless current_user.time_zone.nil?
    end

  end
end
