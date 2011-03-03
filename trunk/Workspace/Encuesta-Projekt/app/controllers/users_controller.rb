class UsersController < ApplicationController
# legt filter vor der angegebenen Methode fest,
# dadurch kann nur nach bestätigung diese nachfolgenden Methoden ausgeführt werden
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  
  #useless
   def index
    @title = "All users"
    @users = User.all
  end



# Controller-Methode zum anlegen eines neuen Benutzers
  def new
  	@user = User.new
    @title = "Registrieren"
  end

# Sucht einen User nach seiner ID heraus und setzt den Seitentitel auf den Namen des Users
# zudem werden die Umfragen des Users herausgesucht und in @surveys gespeichert
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @surveys = @user.surveys

  end

# Die Create-Methode des Controllers legt einen neuen User mit den übergebenen Parametern an
# darauf wird der User gespeichert und der Erfolg davon überprüft.
# bei erfolgt wird ein signIn ausgeführt und eine "Begrüßung" ausgegeben und auf die User-Seite
# weitergeleitet.
# sollte kein Erfolg sich einstellen, wird die Sign-Up-Seite erneut aufgerufen.
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Hallo " + @user.login + "."
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

# Verändert den User, welcher nach seiner ID gefunden wurde und ändert ihn mit den übergebenen Parametern
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

# löscht den User
# erst wird dieser wieder anhand seiner ID gefunden und darauf die Session-User-ID mit der User-ID verglichen
# passen diese NICHT, wird der vorgang abgebrochen und eine Fehlermeldung ausgegeben
# wenn doch, wird eine Delete-Methode nach aufgerufen, die stadartisiert das Objekt löscht... auch aus der Datenbank.
  def delete
    @user =User.find(params[:id])

    if session [:user_id] != @user.user_id
    	               
      flash[:notice] = "Sie haben keine Berechtigung den Benutzer zu l&ouml;schen" 
      redirect_to(users_path)
    end

    if session [:user_id] == @user.user_id
    @user.delete
    end
  end
# Die Update-Methode... sucht den User wieder anhand der ID und ändert die Attribute in der
# Datenbank... bei Erfolgt wird eine Meldung ausgeben und auf die neue User-Seite geleitet
# wenn nicht wird wieder zu Update-Formular geleitet 
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Der Benutzer wurde aktualisiert."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end


  
  private

    def authenticate
      deny_access unless signed_in?
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end



end
