class SurveysController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  def show
    #Testshow für die Surveys.. zeigt den im Cookie gespeicherten Id-Wert an
    #render :text=> cookies[:surveyid]
    @survey = Survey.find(params[:id])
    @title = "Show Survey"
  end

  #Unwichtig
  def index
    flash[:notice] = "You did it"
  end
  
  def new
  	@survey = Survey.new
  end

  #Die Create-Methode, welche von dem _survey_form aufgerufen wird
  # erstellt ein neues Survey über aufruf des aktuellen Users und der übergebenen Parameter
  # gesperrt wird das Survey noch nicht
  # der SurveyType wird über die übergebenen Parameter aus dem Formular ebenfalls eingefügt
  # wenn das Speichert erfolgt ist, wird eine Nachricht ausgeben und das Survey im cookie gespeichert
  # Grund für cookie: diese ID wird für die folgenden Fragen gebraucht
  # darauf wird wieder auf die Home-Seite geleitet
  def create
    @survey = current_user.surveys.build(params[:survey])
    #@survey.gesperrt = params[:survey][:gesperrt]
    @survey.gesperrt = false
    # Statt den übergebenen Parameter zu übernehmen wird hier als Standart erst einmal immer eine Advanced-Umfrage generiert
    # Grund ist der zu hohe Zeitaufwand für die Differenzierung
    #@survey.surveytype = Surveytype.find(params[:survey][:surveytype])
    @survey.surveytype = Surveytype.find(2)
    

    if @survey.save
      flash[:success] = "Umfrage erstellt!"
      #cookies[:surveyid] = @survey.id
      #redirect_to(edit_survey_path(@survey))
      redirect_to new_question_path(:survey_id => @survey.id)
    else
      flash[:failure] = "Bezeichnung fehlt!"
      @feed_items = []

      render 'pages/home'
    end

  #survey.save
  #redirect_to(home_path)
  end

  # Edit-Methode soll aus der übergebenen ID das Survey aus der Datenbank holen
  def edit
    @survey = Survey.find(params[:id])
    @title = "Edit Survey"
  end

  #Löschen Funktions
  def destroy
    @survey.destroy
    redirect_to :back
  end

#	Einfacher Update des Surveys über alle Attribute
  def update
    @survey = Survey.find(params[:id])
    cookies[:surveyid] = @survey.id
    if @survey.update_attributes(params[:survey])
      flash[:success] = "Umfrage bearbeitet."
      redirect_to @survey
    else
      @title = "Edit Survey"
      render 'edit'
    end
  end


# Sperrt die Umfrage (Wirkung im View: keine Bearbeitungen mehr möglich und freigeben für Teilnahme und Auswertung)
  def lock
	@survey = Survey.find(params[:id])
	@survey.gesperrt = true
	@survey.save!
	redirect_to attend_path(:survey_id => @survey.id)
	end


  private

  def authorized_user
    @survey = Survey.find(params[:id])
    redirect_to home_path unless current_user?(@survey.user)
  end
  

end
