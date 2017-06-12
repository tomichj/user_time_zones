require 'spec_helper'

feature 'user time zone' do
  scenario 'with time zone set' do
    login_user
    Time.zone = 'Perth'
    Timecop.freeze '2015-10-19 1:00:00 -0100'
    visit welcome_index_path
    expect(page).to have_content /2015-10-18 19:00:00 -0700/
  end
end
