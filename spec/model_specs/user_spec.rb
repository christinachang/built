require 'spec_helper'

describe User do

  context "a new user is created" do
    before :each do
      @user = User.create(:full_name => 'bob')
    end

    it 'is able to save a user' do
      expect User.find(@user.id)
    end

    it 'is able to assign full name' do
      expect @user.full_name == 'bob'
    end
  end


  it 'is valid with with a full name' do
    user = User.new(full_name: "Bob Whitney")
    expect(user).to be_valid
  end

  it "is invalid without a full name" do
    expect(User.new(full_name: nil)).to have(1).errors_on(:full_name)
  end
 end
