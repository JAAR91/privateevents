require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:name) { 'jaar' }
  user = User.create(username: 'jaar')

  describe 'User and Events' do
    it 'belongs to a user' do
      event = user.events.create(title: 'event title', date: Date.today, location: 'some location',
                           description: 'description of the event')
      expect(event.creator_id).to eq(user.id)
    end

    it 'events are valid with username' do
      user = User.create
      event = user.events.create(title: 'event name', date: Date.today, location: 'some location',
                           description: 'description of the event')
      event2 = user.events.create(title: 'event name', date: Date.today, location: 'some location',
                            description: 'description of the event')
  
      expect(event).to be_valid
      expect(event2).to be_valid
    end

    it 'A User can have many Events' do
      creator = User.create(username: 'jaar')

      event1 = creator.events.create(title: 'event name', date: Date.today, location: 'some location',
                           description: 'description of the event')

      event2 = creator.events.create(title: 'event name2', date: Date.today, location: 'some location again',
                           description: 'description of the event 2')

      creator.events = [event1, event2]
      creator.save
  
      saved_event = User.find(creator.id)
      expect(saved_event.events.size).to eq(2)
    end

  end

  describe 'Events and Attendees' do
    it 'An Event can have many attendees' do
      creator = User.create(name: 'creator')
      event = creator.events.create(title: 'event name', date: Date.today, location: 'some location',
                           description: 'description of the event')
                           
      attendee1 = event.attendees.create(user_id: creator.id, status: 'pending')
      attendee2 = event.attendees.create(user_id: creator.id, status: 'pending')
  
      event.attendees = [attendee1, attendee2]
      event.save
  
      expect(event.attendees.size).to eq(2)
    end


  end
  
  describe 'Users and Attendees' do
    it 'A user can have many attendees' do
      user = User.create(username: 'jaar')
      event = user.events.create(title: 'event name', date: Date.today, location: 'some location',
                            description: 'description of the event')

      attendee1 = event.attendees.create(user_id: user.id, status: 'pending')
      attendee2 = event.attendees.create(user_id: user.id, status: 'pending')
      attendee3 = event.attendees.create(user_id: user.id, status: 'pending')

      expect(event.attendees.size).to eq(3)
    end

    it 'A user can have many event invitations' do
      user = User.create(username: 'jaar')
      user2 = User.create(username: 'Ozzy')
      user3 = User.create(username: 'Eri')

      event = user.events.create(title: 'event name', date: Date.today, location: 'some location',
                            description: 'description of the event')

      event2 = user2.events.create(title: 'event name', date: Date.today, location: 'some location',
                            description: 'description of the event')
                          
      event3 = user3.events.create(title: 'event name', date: Date.today, location: 'some location',
                            description: 'description of the event')

      attendee1 = event.attendees.create(user_id: user.id, status: 'pending')
      attendee2 = event2.attendees.create(user_id: user.id, status: 'accepted')
      attendee3 = event2.attendees.create(user_id: user.id, status: 'accepted')


      expect(user.attendees.size).to eq(3)
    end
  end
end
