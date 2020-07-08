class CreateTrainers < ActiveRecord::Migration[6.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.references :expertise, null: false, foreign_key: true
      t.integer :events_won
      t.string :calendar_url
      t.string :location_url
      t.text :description
      t.string :email

      t.timestamps
    end
  end
end
