class HomeController < ApplicationController

  def index
    

  end
  
  def save_answer
    answer = Answer.create_or_update!(params[:user], params[:ordering])
    render json: { result: :success } 
  end
  
  def company_motivators    
    @motivators = Answer.all.map(&:motivators).
      map{ |list| list.each_with_index.to_a }.
      flatten(1).inject({}) do |result, (item, points)| 
        result[item] ||= 0
        result[item] += points
        result
      end
    @motivators.each { |key, value| @motivators[key] = value / Answer.count.to_f }
    @motivators = @motivators.to_a.sort { |item1, item2| item2.last <=> item1.last }.
      map { |item| Answer::MOTIVATOR_DESC[item.first.to_i] }
  end

end
