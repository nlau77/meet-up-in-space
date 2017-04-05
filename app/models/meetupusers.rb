class MeetupsUser < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  validates :user_id, presence: true
  validates :meetup_id, presence: true
  validate :check_if_user_already_invited?

  def check_if_user_already_invited?
    if !MeetupsUser.where(user_id: user_id).where(meetup_id: meetup_id).empty?
      errors.add(:user_id, "You are already attending this event")
    end
  end

  def cheese
    return "hello"
  end
end
