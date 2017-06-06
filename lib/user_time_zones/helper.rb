module ActionView
  module Helpers

    module FormHelper
      def guess_tz_offset_field(object_name, options = {})
        method = :time_zone_offset
        options['data-behavior'] = 'guess-time-zone-offset'
        hidden_field(object_name, method, options)
      end
    end

    module FormTagHelper
      def guess_tz_offset_field_tag(name = 'user[time_zone_offset]', value = nil, options = {})
        options['data-behavior'] = 'guess-time-zone-offset'
        hidden_field_tag(name, value, options)
      end
    end

  end
end

class ActionView::Helpers::FormBuilder #:nodoc:
  def guess_tz_offset_field(options = {})
    @template.guess_tz_offset_field(@object_name, objectify_options(options))
  end
end
