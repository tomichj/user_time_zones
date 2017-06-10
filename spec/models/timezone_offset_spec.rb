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
      puts @user.time_zone
      expect(@user.time_zone).to eq 'Pacific Time (US & Canada)'
    end

    it 'validates time zone' do
      @user.time_zone = 'not a time zone'
      @user.valid?
      expect(@user.errors[:time_zone]).to include('not included')
    end
  end

end
