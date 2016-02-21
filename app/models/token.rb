class Token < ActiveRecord::Base
  belongs_to :survey

  def generate_key
  	random = ('a'..'z').to_a.sample(4) << rand(1000..9999).to_s
  	random = random.join.split('').shuffle!.join
  	self.url = random
  end
end
