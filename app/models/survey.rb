class Survey < ActiveRecord::Base
  validates :name, presence: true
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  has_many :user_answers, through: :answers
  belongs_to :user
end
