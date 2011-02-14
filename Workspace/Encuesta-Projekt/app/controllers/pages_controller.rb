class PagesController < ApplicationController
  def home
  	@title = "Home"
  end

  def contact
  	@title = "Kontakt"
  end
  
   def help
    @title = "Help"
  end


end
