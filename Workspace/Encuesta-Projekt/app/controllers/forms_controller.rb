class FormsController < ApplicationController
 def new
  	#render :text => cookies[:surveyid]
  	@form = Form.new
  	@title = "Viel Erfolg"
  end
  
  def create
  	if params[:form]
		@form = survey.find(cookies[:surveyid]).forms.create(params[:form])
		
	
		if @form.save
      		flash[:success] = "Frage erstellt!"
			redirect_to edit_survey_path(cookies[:surveyid])
    	else
    		flash[:failure] = "Fehler!"
    		@feed_items = []
    	end
    	
    end
  end

end
