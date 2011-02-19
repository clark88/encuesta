class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
    	@survey = Survey.new
    	@feed_items = current_user.feed
    end
    
  end


  def contact
  	@title = "Kontakt"
  end
  
   def help
    @title = "Help"
  end
  



end
