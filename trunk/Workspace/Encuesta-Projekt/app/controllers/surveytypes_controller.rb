class SurveytypesController < ApplicationController
  def new
  	@surveytype = Surveytype.new
    @title = "Erstellen von neuem Umfragetyp"
  end
  
 #nicht vorgesehen, da eine Änderung das gesamte System durcheinander bringen wird!!
  def edit
  end

  # Entfernen eines Umfragrypen
  def delete
  	@surveytype.destroy
    redirect_back_or home_path  	
  end
  
  #Erstellen eines neunen Umfragetypen (Simple und normal sind standard)
  def create
  	 @surveytype = Surveytype.new(params[:surveytype])
  end

end
