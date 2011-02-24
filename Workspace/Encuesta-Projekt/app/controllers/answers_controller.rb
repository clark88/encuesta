class AnswersController < ApplicationController
  def show
    render :text => cookies[:answertype]
    #render :text => cookies[:questionid]
  end
  
  def new
  	#render :text => cookies[:surveyid]
  	@answer = Answer.new
  	@title = "Neue Antwort"
  end
  
  def create
		
	if params[:answer]
		@answer = Question.find(cookies[:questionid]).answers.create(params[:answer])
		
		@answer.answertype = Answertype.find(cookies[:answertype])
		
		if @answer.save
      		flash[:success] = "Frage erstellt!"
			redirect_to(home_path)
    	else
    		flash[:failure] = "Fehler!"
    		@feed_items = []
    	end
    	
    end

		
  end

  def edit
  end

  def delete
  end

end
