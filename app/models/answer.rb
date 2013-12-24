class Answer < ActiveRecord::Base
  attr_accessible :ordering, :user
  
  def motivators
    ordering.split(',')
  end
  
  def distance(answer) # levenshtein_distance
    size = self.motivators.size
    
    #create temp matrix
    temp_matrix = Array.new(size+1) { Array.new(size+1) }
    (0..size).each do |i| 
      temp_matrix[i][0] = i
      temp_matrix[0][i] = i
    end
    
    (1..size).each do |j|
      (1..size).each do |i|
        temp_matrix[i][j] = if self.motivators[i-1] == answer.motivators[j-1]  # adjust index into string
                              temp_matrix[i-1][j-1]       # no operation required
                            else
                              [ temp_matrix[i-1][j]+1,    # deletion
                                temp_matrix[i][j-1]+1,    # insertion
                                temp_matrix[i-1][j-1]+1,  # substitution
                              ].min
                            end
      end
    end
    temp_matrix[size][size]
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
