class QuestionsController < ApplicationController
  def show
    render :text=> "test"
  end

  def new
  	@question = current_survey.question.build(params[:question])
  end
  
  def create
		#@question = current_survey.questions.build(params[:question])
		@question = Survey.find(:survey_id).questions.create(params[:question])
		#@survey.gesperrt = params[:survey][:gesperrt]
		
		if @question.save
      		flash[:success] = "Frage erstellt!"
			redirect_to(home_path)
    	else
    		flash[:failure] = "Fehler!"
    		@feed_items = []
    	end

		#survey.save
		#redirect_to(home_path)
	end

  def edit
  end

  def delete
  end

end
