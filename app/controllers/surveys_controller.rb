# get '/surveys/:survey_id' do
#   @survey = Survey.find(params[:survey_id])
#   if logged_in?
#     if @survey.user_answers.any?{|user_answer| user_answer.user_id == current_user.id}
#       erb :'/taken-already'
#     else
#       @questions = @survey.questions
#       erb :'surveys/show'
#     end
#   else
#     erb :'/taken-already'
#   end
# end

get '/surveys/:survey_id/tokens' do
  @survey = Survey.find(params[:survey_id])
  @tokens = @survey.tokens
  if @survey.user.id == current_user.id
    erb :token_list
  else
    redirect "/users/#{@token.survey.user_id}"
  end
end

post '/surveys/:survey_id/tokens' do
  @survey = Survey.find(params[:survey_id])
  if logged_in? && @survey.user_id == current_user.id
    token = Token.create(survey_id: @survey.id)
    @tokens = @survey.tokens
    redirect "/surveys/#{@survey.id}/tokens"
  end
    redirect "/users/#{@survey.user_id}"
end

get '/surveys/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  if logged_in? && current_user.id == @survey.user.id
    # UserAnswer.where(answer_id.question.id.survey.id == @survey.id)
    erb :'surveys/results'
  else
    redirect "/surveys/#{@survey.id}"
  end
end

get '/surveys/:survey_id/:key' do
  @url = params[:key]
  token = Token.find_by(url: @url, survey_id: params[:survey_id])
  if token
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    erb :'surveys/show'
    # token.destroy
    # redirect "/surveys/#{token.survey_id}"
  else
    erb :"/surveys/taken-already"
  end
end

post '/surveys/:survey_id/:key' do
  url = params[:key]
  survey = Survey.find(params[:survey_id])
  token = Token.find_by(url: url, survey_id: params[:survey_id])
  if token
    params[:input].each_value do |answer|
      UserAnswer.create(user_id: current_user.id, answer_id: answer)
    end
    token.destroy
    erb :"/surveys/thankyou"
  else
    erb :"/taken-already"
  end
end

