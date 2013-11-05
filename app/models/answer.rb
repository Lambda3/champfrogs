class Answer < ActiveRecord::Base
  attr_accessible :ordering, :user
  
  class << self
    
    def find_or_create! user, ordering
      anwser = Answer.find_by_user(user)
      return anwser if anwser
      Answer.create!(user: user, ordering: ordering)
    end
    
  end
end
