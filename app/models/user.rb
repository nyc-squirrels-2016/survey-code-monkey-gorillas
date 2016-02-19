class User < ActiveRecord::Base
  has_many :surveys
  has_many :user_answers
  has_many :answers, through: :user_answers

  has_secure_password
end
