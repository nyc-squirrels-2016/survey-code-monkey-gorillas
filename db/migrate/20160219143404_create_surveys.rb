class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name, null: false
      t.integer :user_id

      t.timestamps null: false
    end
  end
end