class Surveytype < ActiveRecord::Base
	has_many :surveys
	
	attr_accessible :bezeichnung, :beschreibung
end
