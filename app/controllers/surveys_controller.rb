get '/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  if logged_in?
    if @survey.user_answers.any?{|user_answer| user_answer.user_id == current_user.id}
      erb :'/surveys/taken_already'
    else
      @survey = Survey.find(params[:survey_id])
      @questions = @survey.questions
      @route = "/surveys/#{@survey.id}"
      erb :'/surveys/show'
    end
  else
    erb :'/surveys/no_invite'
  end
end

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
  survey = Survey.find(params[:survey_id])
  if logged_in? && survey.user_id == current_user.id
    token = Token.create(survey_id: survey.id)
    if request.xhr?
      return "http://localhost:9393/surveys/#{survey.id}/#{token.url}"
    else
      erb :'/token_list'
    end
  end
end

get '/surveys/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  if logged_in? && current_user.id == @survey.user.id
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
    @route = "/surveys/#{@survey.id}/#{@url}"
    erb :'surveys/show'
  else
    erb :"/surveys/used_token"
  end
end

post '/surveys/:survey_id' do
  if logged_in?
    params[:input].each_value do |answer|
      UserAnswer.create(user_id: current_user.id, answer_id: answer)
    end
    erb :"/surveys/thankyou"
  else
    erb :"/surveys/no_invite"
  end
end

post '/surveys/:survey_id/:key' do
  url = params[:key]
  survey = Survey.find(params[:survey_id])
  token = Token.find_by(url: url, survey_id: params[:survey_id])
  if token
    user_id = if logged_in?
                current_user.id
              else
                0
              end
    params[:input].each_value do |answer|
      UserAnswer.create(user_id: user_id, answer_id: answer)
    end
    token.destroy
    erb :"/surveys/thankyou"
  else
    erb :"/surveys/used_token"
  end
end

