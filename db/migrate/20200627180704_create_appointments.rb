class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :trainer, null: false, foreign_key: true
      t.references :appointment_status, null: false, foreign_key: true, default: AppointmentStatus.find_by(name: 'pending')

      t.timestamps
    end
  end
end
