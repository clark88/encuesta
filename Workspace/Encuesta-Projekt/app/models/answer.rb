class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :answertype
	has_many   :user_answers
end
