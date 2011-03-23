class FormsController < ApplicationController
  def new
    #render :text => cookies[:surveyid]
    @form = Form.new
    @title = "Viel Erfolg"
  end

  def create
    #render :text => params.inspect
    if params[:commit]
      @form = Survey.find(params[:survey_id]).forms.create(params[:form])
      #render :text => @form.inspect
      survey = Survey.find(params[:survey_id])

      #     params.each{|f|
      #        	#puts p
      #        	#p f.each
      #        	if  f[0][0..8]=="question_"
      #
      #        	 p f[0].split(',answer_')[1]
      #        		#puts params[p]
      #        	end}

      params.each {|parameter|
      #p parameter[0].split(',answer_')[1]
        partparameter = parameter[0].split(',answer_')[1]
        if partparameter == nil
          #keine Textantwort
          #p parameter[0]
          #p parameter[1].class
          #Abfrage auf Multiple-Choice
          if parameter[1].class == ActiveSupport::HashWithIndifferentAccess
            #p parameter[1]
            parameter[1].each do |k,v|
            #puts k
            #puts v
            #dies ist eine Checkbox mit ja
              if v.to_i != 0
              #puts k
              @usranswer = Form.find(@form.id).user_answers.create()
              @usranswer.answer = Answer.find(k)
              @usranswer.save
              end
            end
          else
          #Wir sind bei einer Single-Choice
            if parameter[0][0..8] == "question_"
            #p parameter[1]
            answerparam = parameter[1].to_i
            #p answerparam
            @usranswer = Form.find(@form.id).user_answers.create()
            @usranswer.answer = Answer.find(answerparam)
            @usranswer.save
            end
          end
        else
        #Textantwort
        #p partparameter
        partparameter = partparameter.to_i
        #p partparameter
        #p parameter[1]
        @usranswer = Form.find(@form.id).user_answers.create(partparameter)
        #p Answer.find(partparameter).answertext
        @usranswer.answer = Answer.find(partparameter)
        @usranswer.AnswerText = parameter[1]
        @usranswer.save
        end
        
      }

      if @form.save
        flash[:success] = "Vielen Dank fuer Ihre Teilnahme."

       # Question.find_all_by_survey_id(params[:survey_id]).each do |question|
       #   Answer.find_all_by_question_id(question.id).each do |answer|
          #Hier User_Ansers.create einfügen (wie genau noch unklar, auf Daten warten)
        #  end
       # end

      #Question.find_by_id(params[])

      else
        flash[:failure] = "Fehler!"
      end

    end
  #	redirect_to home_path
  #return
  end

end
