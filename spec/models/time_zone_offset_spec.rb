require 'spec_helper'

describe UserTimeZones::User do
  context 'new user' do
    before(:each) do
      @user = build(:user)
    end

    it 'responds to time_zone_offset=' do
      expect(@user).to respond_to :time_zone_offset=
    end

    it 'responds to time_zone_offset' do
      expect(@user).to respond_to :time_zone_offset
    end

    it 'translates offset to time zone' do
      @user.time_zone_offset = -8
      expect(@user.time_zone).to eq 'Pacific Time (US & Canada)'
    end

    it 'defaults time zone to UTC' do
      expect(@user.time_zone_offset).to eq 0
    end

    it 'time_zone_offset can be updated' do
      @user.time_zone_offset = -10
      @user.time_zone_offset = -8
      expect(@user.time_zone).to eq 'Pacific Time (US & Canada)'
    end
  end

end
