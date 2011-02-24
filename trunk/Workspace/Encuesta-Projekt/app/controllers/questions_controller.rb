class QuestionsController < ApplicationController
  def show
    render :text => cookies[:surveyid]
  end

  def new
  	#render :text => cookies[:surveyid]
  	@question = Question.new
  	@title = "Neue Frage"
  end
  
  def create
		#@question = current_survey.questions.build(params[:question])
		
		@question = Survey.find(cookies[:surveyid]).questions.create(params[:question])
		
		if @question.save
      		flash[:success] = "Frage erstellt!"
			redirect_to(home_path)
    	else
    		flash[:failure] = "Fehler!"
    		@feed_items = []
    	end

		
	end

  def edit
  end

  def delete
  end

end
