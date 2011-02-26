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
			redirect_to edit_survey_path(cookies[:surveyid])
    	else
    		flash[:failure] = "Fehler!"
    		@feed_items = []
    	end
    	
    end

		
  end

 def edit
    @answer = Answer.find(params[:id])
    @title = "Edit Answer"
  end
  
  
  def update
  	@answer = Answer.find(params[:id])
  	
  	
    if @question.update_attributes(params[:question])
      flash[:success] = "Profile updated."
      redirect_to new_answer_path
    else
      @title = "Edit Question"
      render 'edit'
    end
  end

  def delete
  end

end
