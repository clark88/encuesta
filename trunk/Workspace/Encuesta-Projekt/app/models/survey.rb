class Survey < ActiveRecord::Base
	belongs_to :user
	has_many :questions
	belongs_to :surveytype
	
	attr_accessible :bezeichnung, :gesperrt
	
	validates :bezeichnung, :presence => true, :length => { :maximum => 50 }
  	validates :user_id, :presence => true

	
	default_scope :order => 'surveys.created_at DESC'

end
