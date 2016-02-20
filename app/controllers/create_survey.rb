get '/surveys/new' do
  erb :survey_new
end


post '/surveys' do
  @survey = Survey.new(name: params[:survey_name], user_id: current_user.id)
    if @survey.save
      erb :"/question_new", layout: false
      # redirect "/survey/#{@survey.id}/question/new"
    else
      @errors=["You need to put in a survey name"]
      # erb :'error partial'
    end
end


get '/surveys/:survey_id/questions/new' do
  @survey = Survey.find(params[:survey_id])
  erb :question_new
end


post '/surveys/:survey_id/questions' do
  @survey= Survey.find(params[:survey_id])
  @question = Question.new(content: params[:question], survey_id: @survey.id)
  if @question.save
    redirect "/surveys/#{@survey.id}/questions/#{@question.id}/answers/new"
  else
    @errors=["You need to put in a question"]
    # erb :'error partial'
  end
end


get '/surveys/:survey_id/questions/:question_id/answers/new' do
  @survey = Survey.find(params[:survey_id])
  @question = Question.find(params[:question_id])
  erb :answer_new
end


post '/surveys/:survey_id/questions/:question_id/answers' do
  @survey = Survey.find(params[:survey_id])
  params[:answer].each_value do |banana|
    Answer.create(content: banana, question_id: params[:question_id])
  end
    redirect "/surveys/#{@survey.id}/questions/new"
end

