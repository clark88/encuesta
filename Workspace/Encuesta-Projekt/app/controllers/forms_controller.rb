class FormsController < ApplicationController
  def new
    #render :text => cookies[:surveyid]
    @form = Form.new
    @title = "Viel Erfolg"
  end

  def create
  	#render :text => params.inspect
    if params[:commit]
     # params.each{|x| p x if x[0].to_i != 0}
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
        	
        	
        	params.each {|parameter|}
        	
        	
        	if parameter[0].split(',answer_')[1] == nil
        		#keine Textantwort
        		
        		if params[parameter].class == Array
        			
        			
        			params[parameter].each do |k,v|
        				puts v
        				if v != 0
        					#dies ist eine Checkbox mit nein
        				end
        			end
        		end
            else
           		#Textantwort
        	end

        	#Radio
        	Answer.find()
        	
        	#Checkbox
        	
        	#Text
     
      if @form.save
        flash[:success] = "Umfrage vollendet"

        Question.find_all_by_survey_id(params[:survey_id]).each do |question|
          Answer.find_all_by_question_id(question.id).each do |answer|
				#Hier User_Ansers.create einfügen (wie genau noch unklar, auf Daten warten)
          end
        end
        
        
        	
        
        
        #Question.find_by_id(params[])

      else
        flash[:failure] = "Fehler!"
      end
     
    end
#	redirect_to home_path
	#return
  end
  
 
end
