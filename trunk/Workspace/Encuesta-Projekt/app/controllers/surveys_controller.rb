class SurveysController < ApplicationController
  
  def index
		flash[:notice] = "You did it"
	end
  
  def new
  end
  
  def create
		survey = Survey.new()
		survey.gesperrt = params[:survey][:gesperrt]
		
		survey.save
		redirect_to(surveys_path)
	end

  def edit
  end

  def delete
  end

end
