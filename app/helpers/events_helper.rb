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
    return if event.date.nil?
    if event.date.future?
      '(Upcoming Event)'
    else
      '(Event ended)'
    end
  end

  def date_color_status(event)
    return if event.date.nil?
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
    return [] if !event.date.nil? && !event.date.future?
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
    array.push(link_to 'My events', root_path(:time_filter => 'all', :user_id=> current_user.id), class:'nav-link text-dark') if logged_in?
    #array.push(link_to root_path(:time_filter => 'all', :user_id=> current_user.id), class: 'nav-link text-dark') 
    if logged_in?
      array.push(link_to('Invitations', user_attendees_path(current_user.id, time_spec: 'normal'),
                         class: 'nav-link active'))
    end
    array
  end

  def time_filter_links(events)
    array=[]
    
    if params[:user_id].nil?
      array.push(link_to 'All events', root_path(:time_filter => 'all'), class:'link-primary mx-2')
      array.push(link_to 'Future Events', root_path(:time_filter => 'future'), class:'link-success mx-2')
      array.push(link_to 'Past Events', root_path(:time_filter => 'past'), class:'link-dark mx-2')
    else
      array.push(link_to 'All events', root_path(:time_filter => 'all', :user_id=> current_user.id), class:'link-primary mx-2')
      array.push(link_to 'Future Events', root_path(:time_filter => 'future', :user_id=> current_user.id), class:'link-success mx-2')
      array.push(link_to 'Past Events', root_path(:time_filter => 'past', :user_id=> current_user.id), class:'link-dark mx-2')
    end
    array
  end

  def when_events_zero(events)
    if events.count.zero?
      return 'No events yet, click on new event to create a new one' if params[:time_filter] == 'future' || params[:time_filter] == 'all'
      return 'No past events, but click on the button above to create new ones' if params[:time_filter] == 'past'
    end
  end

end
