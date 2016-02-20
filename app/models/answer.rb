class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers
  validates :content, presence: true
end
