class SurveysController < ApplicationController
	
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => :destroy


  
  def index
		flash[:notice] = "You did it"
	end
  
  def new
  end
  
  def create
		@survey = current_user.surveys.build(params[:survey])
		#@survey.gesperrt = params[:survey][:gesperrt]
		@survey.gesperrt = false
		#@survey.surveytype_id = params[:surveytype.id]
		
		if @survey.save
      		flash[:success] = "Umfrage erstellt!"
			redirect_to(home_path)
    	else
    		flash[:failure] = "Umfragetyp oder Bezeichnung fehlt!"
    		@feed_items = []

      		render 'pages/home'
    	end

		#survey.save
		#redirect_to(home_path)
	end

  def edit
  end
  
  def destroy
  	@survey.destroy
    redirect_back_or home_path
  end

  def delete
  end

	private

    def authorized_user
      @survey = survey.find(params[:id])
      redirect_to home_path unless current_user?(@survey.user)
    end

end
