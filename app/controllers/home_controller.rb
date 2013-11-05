class HomeController < ApplicationController

  def index
    

  end
  
  def save_answer
    anwser = Answer.find_or_create!(params[:user], [:ordering])
    render json: { result: :success } 
  end

end
