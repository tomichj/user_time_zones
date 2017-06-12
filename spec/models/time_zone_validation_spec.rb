require 'spec_helper'

describe UserTimeZones::User do
  context 'new user' do
    before(:each) do
      @user = build(:user)
    end

    it 'allows valid time_zone' do
      @user.time_zone = 'Alaska'
      expect(@user.valid?).to be_truthy
    end

    it 'allows default time_zone' do
      expect(@user.valid?).to be_truthy
    end

    it 'rejects nil time zone' do
      @user.time_zone = nil
      expect(@user.valid?).to be_falsey
    end

    it 'rejects bogus time_zone' do
      @user.time_zone = 'not a time zone'
      @user.valid?
      expect(@user.errors[:time_zone].first).to match /not included/
    end
  end

end
