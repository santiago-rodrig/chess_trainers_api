require 'test_helper'

class TrainerTest < ActiveSupport::TestCase
  setup do
    expert = Expertise.find_by_name('expert')

    @trainer = Trainer.new(
      name: 'Pedro Paredes',
      email: 'pedro.paredes@example.org',
      calendar_url: 'https://calendar.google.com/calendar?cid=13123lehjr2',
      location_url: 'https://goo.gl/maps/KX6ckcghfubFo34k',
      expertise: expert,
      events_won: rand(1..9)
    )
  end

  test 'no problem with a valid trainer' do
    assert @trainer.valid?
  end

  test 'the name must be present' do
    @trainer.name = nil

    assert @trainer.invalid?
  end

  test 'the name length must be greater than 2' do
    @trainer.name = 'aa'

    assert @trainer.invalid?
  end

  test 'the name length must be at most 50' do
    @trainer.name = 'a' * 51

    assert @trainer.invalid?
  end

  test 'events won must be nonnegative' do
    @trainer.events_won = -1

    assert @trainer.invalid?
  end

  test 'the calendar url must be a valid URI' do
    @trainer.calendar_url = 'blurbalize'

    assert @trainer.invalid?
  end

  test 'the location url must be a valid URI' do
    @trainer.location_url = 'cacahuate'

    assert @trainer.invalid?
  end

  test 'the email must have a valid format' do
    @trainer.email = 'some random string'

    assert @trainer.invalid?
  end

  test 'email must be unique' do
    @trainer.email = trainers(:one).email

    assert @trainer.invalid?
  end

  test 'calendar url must be unique' do
    @trainer.calendar_url = trainers(:two).calendar_url

    assert @trainer.invalid?
  end
end
