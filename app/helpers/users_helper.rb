module UsersHelper
  def user_session(user)
    array = []
    if user
      array.push(link_to('Sign Out', logout_path, method: :destroy, class: 'nav-link active'))
    else
      array.push(link_to('Register', new_user_path, class: 'nav-link active'))
      array.push(link_to('Sign In', login_path, class: 'nav-link active'))
    end
    array
  end

  def user_name(user)
    if user.nil?
      'Not logged in'
    else
      user.name
    end
  end

  def nav_bar_links
    array = []
    if logged_in?
      array.push(link_to('My events', root_path(time_filter: 'all', user_id: current_user.id),
                         class: 'nav-link text-dark'))
    end
    if logged_in?
      array.push(link_to('Invitations', user_attendees_path(current_user.id, time_spec: 'all'),
                         class: 'nav-link active'))
    end
    array
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
end
