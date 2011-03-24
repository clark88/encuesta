class QuestionsController < ApplicationController
  #Die Show-methodde ... wird nicht viel machen
  def show
    #render :text => cookies[:surveyid]
    #render  :text => cookies[:answertype]
    #render :text => cookies[:questionid]
  end

  # New-Methode  wird über das new-View initialisiert, ohne wird das view-template nicht geöffnet
  def new
    #render :text => cookies[:surveyid]
    @question = Question.new
    @title = "Neue Frage"
  end

  # Legt die neue Frage in die Datenbank, dabei ruft das Mutter-Survey die create Methode auf.
  def create

    #@question = current_survey.questions.build(params[:question])

    @question = Survey.find(params[:survey_id]).questions.create(params[:question])

    surveyid = Survey.find(params[:survey_id]).id

    answertype = Answertype.find(params[:answertype])

    if @question.save
      flash[:success] = "Frage erstellt!"
      #cookies[:questionid] = @question.id

      #cookies[:answertype] = answertype.id
      redirect_to new_answer_path(:survey_id => surveyid, :question_id =>@question.id, :answertype => answertype.id)
    else
      flash[:failure] = "Fehler!"
      @feed_items = []
      cookies.delete :answertype
    end

  end

  def edit
    @question = Question.find(params[:id])
    @title = "Edit Question"
  end

  #  def deleteanswers
  #
  #  	@question = Question.find(params[:id])
  #  		Answer.delete_all_by_question_id(@question.id)
  #
  #
  # 		cookies[:answertype] = answertype.id
  #
  #
  # 		redirect_to answer_new_path
  #	end

#	Verändert die Question (Text und Answertypes) und löscht alle Antworten zu der Frage.
# 	Der Grund dafür liegt darin, dass sonst für alle Antworten die Antworttypen verändert werden müssten.
#   Nach Vollendung wird sofort zu einer new-View für Antworten verlinkt, um mindestens eine Antwort mit dem 
#   Neuen Answertype zu haben (sonst würde ein Fehler bei Edit-View erscheinen)
  def update
    @question = Question.find(params[:id])

    survey = Survey.find(params[:survey_id])

    answertype = Answertype.find(params[:answertype])
    #cookies[:answertype] = answertype.id
    #cookies[:questionid] = @question.id

    #Answer.delete_all( "question_id = ")

    Answer.find_all_by_question_id(@question.id).each do |answer|
      Answer.destroy(answer.id)
    end

    if @question.update_attributes(params[:question])
      flash[:success] = "Frage bearbeitet."
      redirect_to new_answer_path(:survey_id => survey.id, :question_id => @question.id, :answertype => answertype)
    else
      @title = "Edit Question"
      render 'edit'
    end
  end

  def destroy
    #p params[:id].to_i
    question = Question.find(params[:id].to_i)

    question.destroy
    redirect_to :back
  end

end
