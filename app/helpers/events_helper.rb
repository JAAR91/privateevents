module EventsHelper
  def event_title(user, event)
    if user
      link_to event.title, event_path(event.id),
              class: 'link-info text-decoration-none text-break'

    else
      event.title
    end
  end

  def event_date_status(event)
    if event.date.future?
      '(Upcoming Event)'
    else
      '(Previous Event)'
    end
  end

  def date_color_status(event)
    if event.date.future?
      'link-success'
    else
      'link-danger'
    end
  end

  def event_post(user)
    if user.nil?
      nil
    else
      link_to '<button class="btn btn-success" type="button">Create Event</button>'.html_safe,
              new_user_event_path(current_user.id),
              class: 'link-success text-decoration-none text-uppercase'
    end
  end

  def modify_event(event)
    array = []
    if current_user.id == event.user_id
      array[0] = link_to 'Edit',
                         edit_user_event_path(current_user.id, event.id),
                         class: 'mx-2 text-decoration-none link-primary'
      array[1] = link_to 'Destroy', user_event_path(current_user.id, event.id),
                         method: :delete, data: { confirm: 'Are you sure?' },
                         class: 'link-danger mx-2 text-decoration-none'
      return array
    end
    []
  end

  def freq
    ['only once', 'once a week', 'once a month', 'once every 2 month', 'once every 3 month',
     'once every 6 month']
  end

  def e_type
    ['type', 'Appearance or Signing', 'Attraction', 'Camp, Trip, or Retreat', 'Class, Training, or Workshop',
     'Concert or Performance', 'Conference', 'Convention', 'Dinner or Gala', 'Festival or Fair',
     'Game or Competition', 'Meeting or Networking Event', 'Other', 'Party or Social Gathering',
     'Race or Endurance Event', 'Rally', 'Screening', 'Seminar or Talk', 'Tour', 'Tournament',
     'Tradeshow, Consumer Show, or Expo']
  end

  def e_category
    ['Category', 'Auto, Boat & Air', 'Business & Professional', 'Charity & Causes', 'Community & Culture',
     'Family & Education', 'Fashion & Beauty', 'Film, Media & Entertainment', 'Food & Drink',
     'Government & Politics', 'Health & Wellness', 'Hobbies & Special Interest', 'Home & Lifestyle',
     'Music', 'Other', 'Performing & Visual Arts', 'Religion & Spirituality', 'School Activities',
     'Science & Technology', 'Seasonal & Holiday', 'Sports & Fitness', 'Travel & Outdoor']
  end

  def nav_bar_links
    array = []
    array.push(link_to('My Own events', user_events_path(current_user.id), class: 'nav-link text-dark')) if logged_in?
    if logged_in?
      array.push(link_to('Invitations', user_attendees_path(current_user.id, time_spec: 'normal'),
                         class: 'nav-link active'))
    end
    array
  end
end
