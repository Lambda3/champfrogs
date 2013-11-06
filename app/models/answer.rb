class Answer < ActiveRecord::Base
  attr_accessible :ordering, :user
  
  def motivators
    ordering.split(',')
  end
  
  class << self
    
    def create_or_update! user, ordering
      answer = Answer.find_by_user(user)
      if answer
        answer.ordering = ordering
        answer.save!
      else
        Answer.create!(user: user, ordering: ordering)
      end
    end
    
  end
end
