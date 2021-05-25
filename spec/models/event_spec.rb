require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:name) { 'jaar' }

  describe 'User and Events' do
    it 'belongs to a user' do
      user = User.new(username: 'jaar3', name: 'jaar jaar jaar')
      user.save
      event = user.events.create(title: 'event title', description: 'description of the event',
                                 tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                 date: Date.today, location: 'some location')

      expect(event.creator_id).to eq(user.id)
    end

    it 'events are valid with username' do
      user = User.new(username: 'jaar3', name: 'jaar jaar jaar')
      user.save
      event = user.events.new(title: 'event title', description: 'description of the event',
                              tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                              date: Date.today, location: 'some location')

      event2 = user.events.new(title: 'event title', description: 'description of the event',
                               tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                               date: Date.today, location: 'some location')

      expect(event).to be_valid
      expect(event2).to be_valid
    end

    it 'A User can have many Events' do
      creator = User.new(username: 'jaar3', name: 'jaar jaar jaar')
      creator.save
      event1 = creator.events.create(title: 'event title', description: 'description of the event',
                                     tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                     date: Date.today, location: 'some location')

      event2 = creator.events.create(title: 'event title', description: 'description of the event',
                                     tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                     date: Date.today, location: 'some location')

      creator.events = [event1, event2]
      creator.save

      saved_event = User.find(creator.id)
      expect(saved_event.events.size).to eq(2)
    end
  end

  describe 'Events and Attendees' do
    it 'An Event can have many attendees' do
      creator = User.new(username: 'jaar3', name: 'jaar jaar jaar')
      creator.save
      event = creator.events.create(title: 'event title', description: 'description of the event',
                                    tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                    date: Date.today, location: 'some location')

      attendee1 = event.attendees.create(user_id: creator.id, status: 'pending')
      attendee2 = event.attendees.create(user_id: creator.id, status: 'pending')

      event.attendees = [attendee1, attendee2]
      event.save

      expect(event.attendees.size).to eq(2)
    end
  end

  describe 'Users and Attendees' do
    it 'A user can have many attendees' do
      user = User.new(username: 'jaar3', name: 'jaar jaar jaar')
      user.save
      event = user.events.create(title: 'event title', description: 'description of the event',
                                 tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                 date: Date.today, location: 'some location')

      event.attendees.create(user_id: user.id, status: 'pending')
      event.attendees.create(user_id: user.id, status: 'pending')
      event.attendees.create(user_id: user.id, status: 'pending')

      expect(event.attendees.size).to eq(3)
    end

    it 'A user can have many event invitations' do
      user = User.new(username: 'jaar3', name: 'jaar jaar jaar')
      user2 = User.new(username: 'eri', name: 'jaar jaar jaar')
      user3 = User.new(username: 'ozzy', name: 'jaar jaar jaar')

      user.save
      user2.save
      user3.save

      event = user.events.create(title: 'event title', description: 'description of the event',
                                 tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                 date: Date.today, location: 'some location')

      event2 = user2.events.create(title: 'event title', description: 'description of the event',
                                   tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                   date: Date.today, location: 'some location')

      event3 = user3.events.create(title: 'event title', description: 'description of the event',
                                   tpeople: 2, frequency: 'freq', eventtype: 'type', eventcategory: 'cat',
                                   date: Date.today, location: 'some location')

      event.attendees.create(user_id: user.id, status: 'pending')
      event2.attendees.create(user_id: user.id, status: 'accepted')
      event3.attendees.create(user_id: user.id, status: 'accepted')

      expect(user.attendees.size).to eq(3)
    end
  end
end
