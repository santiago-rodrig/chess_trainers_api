# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Appointment.delete_all
Trainer.delete_all
AppointmentStatus.delete_all
Expertise.delete_all
Expertise.create([
  { name: 'amateur' },
  { name: 'intermediate' },
  { name: 'expert' }
])
AppointmentStatus.create([
  { name: 'success' },
  { name: 'fail' },
  { name: 'pending' }
])
Trainer.create([
  {
    name: 'Trainer 1',
    expertise: Expertise.find_by(name: 'expert'),
    events_won: 8,
    calendar_url: 'https://google.com',
    location_url: 'https://google.com',
    email: 'santo1996.29@gmail.com',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  },
  {
    name: 'Trainer 2',
    expertise: Expertise.find_by(name: 'intermediate'),
    events_won: 4,
    calendar_url: 'https://google.com',
    location_url: 'https://google.com',
    email: 'santo1996.29@gmail.com',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  },
  {
    name: 'Trainer 3',
    expertise: Expertise.find_by(name: 'intermediate'),
    events_won: 5,
    calendar_url: 'https://google.com',
    location_url: 'https://google.com',
    email: 'santo1996.29@gmail.com',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  },
  {
    name: 'Trainer 4',
    expertise: Expertise.find_by(name: 'amateur'),
    events_won: 2,
    calendar_url: 'https://google.com',
    location_url: 'https://google.com',
    email: 'santo1996.29@gmail.com',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  }
])
Appointment.create([
  { trainer: Trainer.first, appointment_status: AppointmentStatus.find_by(name: 'pending') },
  { trainer: Trainer.offset(1).first, appointment_status: AppointmentStatus.find_by(name: 'fail') },
  { trainer: Trainer.offset(2).first, appointment_status: AppointmentStatus.find_by(name: 'success') },
  { trainer: Trainer.last, appointment_status: AppointmentStatus.find_by(name: 'pending') }
]);