class UniqueMessageValidator < ActiveModel::Validator
  def validate(record)
    item = UserMessage.where('message = :message and user_id = :user and created_at >= :date', message: record.message, user: record.user, date: Date.current).first
    if item && item.id != record.id && item.created_at.strftime("%Y-%m-%d").eql?(Date.current.strftime("%Y-%m-%d"))
      record.errors.add( :message, "You can't write a same message twice a day")
    end
  end
end
