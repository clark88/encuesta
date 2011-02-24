class Survey < ActiveRecord::Base
	
	belongs_to :user
	has_many :questions
	has_many :form
	belongs_to :surveytype
	
	attr_accessible :bezeichnung, :gesperrt, :surveytype_id
	
	#prüft die anwesenheit von Bezeichnung, einer User_id und einer Umfragetyp_id
	validates :bezeichnung, :presence => true, :length => { :maximum => 50 }
  	validates :user_id, :presence => true
  	validates :surveytype_id, :presence => true
	
	
	
	default_scope :order => 'surveys.created_at DESC'

end
