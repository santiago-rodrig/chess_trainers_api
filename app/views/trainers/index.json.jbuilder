# app/views/trainers/index.json.jbuilder

json.array! @trainers do |trainer|
  json.(trainer, :name, :events_won, :calendar_url, :location_url)
  json.expertise trainer.expertise.name
end
