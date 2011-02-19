class SurveytypesController < ApplicationController
  def new
  	@surveytype = Surveytype.new
    @title = "Erstellen von neuem Umfragetyp"
  end

  def edit
  end

  def delete
  end
  
  def create
  	 @surveytype = Surveytype.new(params[:surveytype])
  end

end
