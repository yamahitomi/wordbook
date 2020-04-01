class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.text :description
      t.timestamp :created_at
      t.timestamp :update_at

      t.timestamps
    end
  end
end
