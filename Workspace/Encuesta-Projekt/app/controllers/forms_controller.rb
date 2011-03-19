class FormsController < ApplicationController
  def new
    #render :text => cookies[:surveyid]
    @form = Form.new
    @title = "Viel Erfolg"
  end

  def create
  	render :text => params.inspect
    if params[:commit]
      params.each{|x| p x if x[0].to_i != 0}
      @form = Survey.find(cookies[:surveyid]).forms.create(params[:form])
	  render :text => @form.inspect
      survey = Survey.find(params[:surveyid])

     
      if @form.save
        flash[:success] = "Umfrage vollendet"

        Question.find_all_by_survey_id(survey.id).each do |f|
          Answer.find_all_by_question_id(question.id).each do |answer|
				#Hier User_Ansers.create einfügen (wie genau noch unklar, auf Daten warten)
          end
        end

      else
        flash[:failure] = "Fehler!"
      end
     
    end
#	redirect_to home_path

  end
  
 
end
