module ApplicationHelper
	
	
def logo
    image_tag("logo.jpg", :alt => "Encuesta-Umfragen", :class => "round")
 end
 
 def greyroundtopleft
 	image_tag("roundedcornr_335844_tl.png")
 end
 
 def greyroundtopright
 	image_tag("roundedcornr_335844_tr.png")
 end
 
 def greyroundbottomleft
 	image_tag("roundedcornr_335844_bl.png")
 end
 
 def greyroundbottomright
 	image_tag("roundedcornr_335844_br.png")
 end
 
 def loginPic
 	image_tag("Login.png", :alt => "Login", :class => "round")
 end
 
 def goPic
 	image_tag("GO.png", :alt => "Los gehts!", :class => "round")
 end
 
 def registerPic
 	image_tag("Neuregistieren.png", :alt => "Hier registrieren", :class => "round")
 end
end
