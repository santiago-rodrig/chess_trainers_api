class CreateExpertises < ActiveRecord::Migration[6.0]
  def change
    create_table :expertises do |t|
      t.string :name

      t.timestamps
    end
    Expertise.create([
      { name: 'expert' },
      { name: 'intermediate' },
      { name: 'amateur' }
    ])
  end
end
