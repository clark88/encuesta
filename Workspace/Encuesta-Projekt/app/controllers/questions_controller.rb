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
    @question = Question.find(params[:id])
    @title = "Edit Question"
  end
  
  def update
  	@question = Question.find(params[:id])
    if @question.update_attributes(params[:survey])
      flash[:success] = "Profile updated."
      redirect_to @survey
    else
      @title = "Edit Survey"
      render 'edit'
    end
  end

  def delete
  end

end
