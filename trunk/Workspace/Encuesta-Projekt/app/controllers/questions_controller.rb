class QuestionsController < ApplicationController
  def show
    #render :text => cookies[:surveyid]
    render  :text => cookies[:answertype]
    #render :text => cookies[:questionid]
  end

  def new
  	#render :text => cookies[:surveyid]
  	@question = Question.new
  	@title = "Neue Frage"
  end
  
  def create
  	
  		
		#@question = current_survey.questions.build(params[:question])
		
		@question = Survey.find(cookies[:surveyid]).questions.create(params[:question])
		
		answertype = Answertype.find(params[:answertype])
		
		if @question.save
      		flash[:success] = "Frage erstellt!"
      		cookies[:questionid] = @question.id
      		
      		cookies[:answertype] = answertype.id
			redirect_to(home_path)
    	else
    		flash[:failure] = "Fehler!"
    		@feed_items = []
    		cookies.delete :answertype
    	end

		
	end

  def edit
  end

  def delete
  end

end
