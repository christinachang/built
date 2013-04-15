require 'spec_helper'

describe User do
  it 'should be able to save a user' do
    @user = User.create(:full_name => 'bob')
    expect User.find(@user.id)
  end

  it 'should be able to assign full name' do
    @user = User.create(:full_name => 'bob')
    expect @user.full_name == 'bob'
  end

 end
