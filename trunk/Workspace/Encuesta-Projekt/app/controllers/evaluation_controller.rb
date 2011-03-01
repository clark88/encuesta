class EvaluationController < ApplicationController
	 
  def show
      flash[:success] = "Hallo!"
  end
	 
	# Diese Methode Ruft die jeweilige Umfrage auf und zeigt die Ergebniswerte neben den Fragen an
	### Es handelt sich hier um einen Entwurf, die ganze Funktionalität lässt sich vermutlich leichter in der
	### View umsetzten.
	def evaluate
		survey = Survey.find(params[:id])
		q = Question.where(:servayid => params[:id])
		q.each do |question|
			#Umfragename ausgeben
			flash[:success] = survay.name
			#Frage wird ausgegeben
			flash[:success] = question.questiontext
			
			a = Answer.where(:question.id => question.id)
			a.each do |answer|
				 #Antwort wird ausgegeben
			flash[:success] = answer.answertext
				
			###Prüfund des Fragetyps ###
			
			 if a.answertype_id = 1 || a.answertype_id = 2
				#Count über die Anworten der User
				c = user_answer.Count.Where(:answer_id => answer.id, :AnswerBoolean => "t")
				#Augabe der Anzahl für die gegbenen Antworten
				flash[:success] = c
			 end
			 #Ausgabe der Textantworten 
			 #### Hier muss in der Finalen Version noch eine Filtermöglichkeit 
			 #### implementiert werden.
			 if a.answertype_id = 3
			 	tfa = user_answer.Where(:answer_id => answer.id)
			 	tfa.each do |utfa|
			 		flash[:success] = utfa.AnswerText 
			 	end
			 end
			 #Durchschnittswert des Nummernfeldes wird berechnet und ausgegeben				
			 if a.ansertype_id = 4
			 	#### kommt...
			 end
			end
		end
	end
	
end
