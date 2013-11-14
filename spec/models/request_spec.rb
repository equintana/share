require 'spec_helper'

describe Request do
  it { should belong_to :user }
  it { should validate_presence_of :receiver_id }

  before :each do
  	@user = FactoryGirl.create(:user)
  end
  it "does not allow to send a request twice for the same user if pending" do
  	request = FactoryGirl.create(:request, user: @user, receiver_id: 2)
  	request2 = FactoryGirl.build(:request, user: @user, receiver_id: 2)
  	request2.should_not be_valid
	request2.should have(1).error_on(:receiver_id)
  end

  it "does not allow to ad myself as a friend" do

  	req = FactoryGirl.create(:request, user: @user, receiver_id: @user.id)

  	req.should_not be_valid
	req.should have(1).error_on(:receiver_id)
  end
end
