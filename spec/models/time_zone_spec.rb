require 'spec_helper'

describe UserTimeZones::User do
  context 'new user' do
    before(:each) do
      @user = build(:user)
    end

    it 'responds to time_zone=' do
      expect(@user).to respond_to :time_zone=
    end

    it 'responds to time_zone' do
      expect(@user).to respond_to :time_zone
    end

    it 'defaults to UTC' do
      expect(@user.time_zone).to eq 'UTC'
    end

    it 'translates time zone to offset' do
      @user.time_zone = 'Alaska'
      expect(@user.time_zone_offset).to eq -9
    end

    it 'time_zone can be updated' do
      @user.time_zone = 'Alaska'
      @user.time_zone = 'UTC'
      expect(@user.time_zone_offset).to be 0
    end
  end
end
