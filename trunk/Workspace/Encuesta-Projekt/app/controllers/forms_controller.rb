class FormsController < ApplicationController
  def new
    #render :text => cookies[:surveyid]
    @form = Form.new
    @title = "Viel Erfolg"
  end

  def create
    if params[:form]
      @form = survey.find(cookies[:surveyid]).forms.create(params[:form])

      survey = Survey.find(params[:surveyid])

     
      if @form.save
        flash[:success] = "Umfrage vollendet"

        Question.find_all_by_survey_id(survey.id).each do |f|
          Answer.find_all_by_question_id(question.id).each do |answer|
				User_Answer.new
          end
        end

        redirect_to home_path
      else
        flash[:failure] = "Fehler!"
      end

    end
  end

end
