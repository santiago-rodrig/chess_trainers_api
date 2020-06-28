class AddUserToAppointments < ActiveRecord::Migration[6.0]
  def change
    change_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
    end
  end
end
