# app/views/trainers/index.json.jbuilder

json.last_group @last_group

json.trainers @trainers do |trainer|
  json.(trainer, :name, :events_won, :calendar_url, :location_url)
  json.expertise trainer.expertise.name
end