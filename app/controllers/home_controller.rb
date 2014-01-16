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

  def like_me
    data = Answer.all.to_a
    my_answer = data.select { |i| i.user == params[:user] }.first    
    @result = (data - [my_answer]).
      map { |item| { item => item.distance(my_answer) } }.
      sort { |item1, item2| item1.values.first <=> item2.values.first}
    puts @result.map{ |item| "#{item.keys.first.user} => #{item.values.first}"}.join("<br>")
  end
  
  def biggest_matches
    all = Answer.all.to_a
    biggest = all.map do |item| 
      matches = (all - [item]).inject({}) do |r, answer| 
        r["#{item.user} => #{answer.user}"] = item.distance(answer)
        r
      end
      best_matches = matches.values.min
      matches.select { |k,v| v == best_matches }
    end.sort { |item1, item2| item1.values.min <=> item2.values.min }
    render :text => biggest.to_json
  end

end
