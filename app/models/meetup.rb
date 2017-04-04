class Meetup < ActiveRecord::Base
  has_and_belongs_to_many :users

  def has_errors?
    if self.name == "" || self.location == "" || self.description == ""
      return true
    end
    false
  end

  # def error_message
  #   return some errors and stuff
  # end
end
