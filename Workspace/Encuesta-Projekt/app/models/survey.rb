class Survey < ActiveRecord::Base
	belongs_to :user
	has_many :questions
	belongs_to :surveytype
end
