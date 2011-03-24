class AnswersController < ApplicationController
  def show
    # render :text => cookies[:answertype]
    #render :text => cookies[:questionid]
  end

  #Methode für die new-View
  def new
    #render :text => cookies[:surveyid]
    @answer = Answer.new
    @title = "Neue Antwort"
  end

  #Erstellt über die Question die neue Antwort und versieht sie mit dem ausgewählten Answertype
  #Ist eine Antwort erstellt, wird erneut auf die new-View verwiesen
  def create

    if params[:answer]
      @answer = Question.find(params[:question_id]).answers.create(params[:answer])

      question_id = Question.find(params[:question_id])
      survey_id = Survey.find(params[:survey_id])

      @answer.answertype = Answertype.find(params[:answertype])

      if @answer.save
        flash[:success] = "Frage erstellt!"
        #redirect_to edit_survey_path(params[:survey_id])
        redirect_to new_answer_path(:question_id => question_id, :answertype => @answer.answertype, :survey_id => survey_id)

      #redirect_to new_answer_path(:question_id, :answertype)

      else
        flash[:failure] = "Fehler!"
      @feed_items = []
      end

    end

  end

  #Edit-View
  def edit
    @answer = Answer.find(params[:id])
    @title = "Edit Answer"
  end

  #Die Antwort wird über ihren Antworttext verändert
  def update
    @answer = Answer.find(params[:id])

    if @answer.update_attributes(params[:answer])
      flash[:success] = "Profile updated."
      redirect_to edit_question_path(params[:question_id])
    else
      @title = "Edit Question"
      render 'edit'
    end
  end

  #sucht aus dem übergebenen Parameter die Id und ermittelt die Antwort, welche zerstört wird
  def destroy
    #p params[:id].to_i
    answer = Answer.find(params[:id].to_i)

    answer.destroy
    redirect_to :back
  end

end
