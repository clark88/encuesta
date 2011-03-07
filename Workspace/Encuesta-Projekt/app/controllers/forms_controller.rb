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
      		flash[:success] = "Umfrage vollendet"
			redirect_to home_path
    	else
    		flash[:failure] = "Fehler!"
    	end
    	
    end
  end

end
