class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  has_many :user_answers, through: :answers
  validates :content, presence: true
end
