class CreateTrainers < ActiveRecord::Migration[6.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.references :expertise, null: false, foreign_key: true
      t.integer :events_won
      t.string :calendar_url
      t.string :location_url

      t.timestamps
    end
    Trainer.create([
      {
        name: 'Trainer 1',
        expertise: Expertise.find_by(name: 'expert'),
        events_won: 8,
        calendar_url: 'https://google.com',
        location_url: 'https://google.com'
      },
      {
        name: 'Trainer 2',
        expertise: Expertise.find_by(name: 'intermediate'),
        events_won: 4,
        calendar_url: 'https://google.com',
        location_url: 'https://google.com'
      },
      {
        name: 'Trainer 3',
        expertise: Expertise.find_by(name: 'intermediate'),
        events_won: 5,
        calendar_url: 'https://google.com',
        location_url: 'https://google.com'
      },
      {
        name: 'Trainer 4',
        expertise: Expertise.find_by(name: 'amateur'),
        events_won: 2,
        calendar_url: 'https://google.com',
        location_url: 'https://google.com'
      }
    ])
  end
end
