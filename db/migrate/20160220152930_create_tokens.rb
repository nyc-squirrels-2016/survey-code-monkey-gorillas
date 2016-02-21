class CreateTokens < ActiveRecord::Migration
  def change
  	create_table :tokens do |t|
  		t.string :url
  		t.integer :survey_id
  	end
  end
end
