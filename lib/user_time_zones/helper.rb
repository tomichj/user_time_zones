module ActionView
  module Helpers

    module FormHelper
      def guess_tz_offset_field(object_name, options = {})
        time_zone_javascript()
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

    private

    def time_zone_javascript(event_on = 'turbolinks:load')
      puts 'doing javascript timze zone'
      javascript_tag(<<-EOS
function guessTimeZoneOffset() {
  var offset = -(new Date().getTimezoneOffset() / 60);
  var field = document.querySelector("[data-behavior~=guess-time-zone-offset]");
  if (field) {
    field.value = offset;
  }
}

document.addEventListener("#{event_on}", guessTimeZoneOffset);
EOS
      )
    end
  end
end

class ActionView::Helpers::FormBuilder #:nodoc:
  def guess_tz_offset_field(options = {})
    @template.guess_tz_offset_field(@object_name, objectify_options(options))
  end
end


# form_helper.hidden_field(:time_zone_offset, data: { behavior: 'guess-time-zone-offset' })
# <input data-behavior="guess-time-zone-offset" type="hidden" value="-7" name="signup[time_zone_offset]" id="signup_time_zone_offset">

