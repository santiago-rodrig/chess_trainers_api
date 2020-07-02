json.last_group @last_group
json.appointments @appointments do |appointment|
  json.trainer appointment.trainer.name
  json.call(appointment, :created_at)
  json.status appointment.appointment_status.name
end
