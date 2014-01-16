class Answer < ActiveRecord::Base
  attr_accessible :ordering, :user
  
  def motivators
    ordering.split(',')
  end
  
  def distance(answer) # levenshtein_distance
    motivators.map.with_index do |item, index|
      i = answer.motivators.index(item)
      (i - index).abs
    end.inject(0) { |r,i| r + i}
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
