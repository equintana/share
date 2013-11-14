class Request < ActiveRecord::Base
  attr_accessible :is_accepted, :receiver_id

	validates :receiver_id, presence: true
	validate :check_pending_request
  validate :self_request

  belongs_to :user

  def check_pending_request
  	request = Request.where("user_id = :user and receiver_id = :receiver", user: user , receiver: self.receiver_id).first
  	if request.present? && !request.is_accepted
  		errors.add(:receiver_id, "You have a Request Pending for approval right now for this user")
  	end
  end

  def self_request
    if user == self.receiver_id
      errors.add(:receiver_id, "You can send a request yo yourself")
    end
  end

end
