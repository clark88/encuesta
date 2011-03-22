class AnswersController < ApplicationController
  def show
   # render :text => cookies[:answertype]
    #render :text => cookies[:questionid]
  end
  
  def new
  	#render :text => cookies[:surveyid]
  	@answer = Answer.new
  	@title = "Neue Antwort"
  end
  
  def create
		
	if params[:answer]
		@answer = Question.find(params[:question_id]).answers.create(params[:answer])
		
		question_id = Question.find(params[:question_id])
		survey_id = Survey.find(params[:survey_id]) 
		
		@answer.answertype = Answertype.find(params[:answertype])
		
		if @answer.save
      		flash[:success] = "Frage erstellt!"
			#redirect_to edit_survey_path(params[:survey_id])
			redirect_to new_answer_path(:question_id => question_id, :answertype => @answer.answertype, :survey_id => survey_id)

			#redirect_to new_answer_path(:question_id, :answertype) 

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
  	
  	
    if @answer.update_attributes(params[:answer])
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
