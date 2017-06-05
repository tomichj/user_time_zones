class AddTimeZoneToUsers < ActiveRecord::Migration<%= migration_version %>
  def change
    add_column :<%= table_name %>, :time_zone, :string, default: 'UTC'
  end
end
