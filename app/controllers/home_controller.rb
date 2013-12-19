class HomeController < ApplicationController

  def index
    

  end
  
  def save_answer
    Answer.create_or_update!(params[:user], params[:ordering])
    render json: { result: :success } 
  end
  
  def company_motivators    
    sum_points = -> (result, (item, points)) { result[item] ||= 0 ; result[item] += points ; result }
    average_points = -> (result, (key, value)) { result[key] = value / Answer.count.to_f ; result }
    @motivators = Answer.all.map(&:motivators).
      map{ |list| list.each_with_index.to_a }.
      flatten(1).
      inject({}, &sum_points).
      inject({}, &average_points).
      to_a.
      sort { |item1, item2| item1.last <=> item2.last }
    @already_answered = Answer.all.map(&:user)
  end

end
