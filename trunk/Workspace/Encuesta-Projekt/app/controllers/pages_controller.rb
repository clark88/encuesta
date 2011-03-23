class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
    	@survey = Survey.new
    	@feeds = current_user.feed
    end
    
  end


  def contact
  	@title = "Kontakt"
  end
  
   def help
    @title = "Help"
  end
  
  def impressum
  	@title = "Impressum"
  end
  



end
