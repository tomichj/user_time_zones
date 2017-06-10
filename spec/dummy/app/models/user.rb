class User < ActiveRecord::Base
  include UserTimeZones::User

end
