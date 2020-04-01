class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.integer :highest_rate
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
