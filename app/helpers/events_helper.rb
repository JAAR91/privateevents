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

  def time_filter_links(_events)
    array = []

    if params[:user_id].nil?
      array.push(link_to('All events', root_path(time_filter: 'all'), class: 'link-primary mx-2'))
      array.push(link_to('Future Events', root_path(time_filter: 'future'), class: 'link-success mx-2'))
      array.push(link_to('Past Events', root_path(time_filter: 'past'), class: 'link-dark mx-2'))
    else
      array.push(link_to('All events', root_path(time_filter: 'all', user_id: current_user.id),
                         class: 'link-primary mx-2'))
      array.push(link_to('Future Events', root_path(time_filter: 'future', user_id: current_user.id),
                         class: 'link-success mx-2'))
      array.push(link_to('Past Events', root_path(time_filter: 'past', user_id: current_user.id),
                         class: 'link-dark mx-2'))
    end
    array
  end

  def when_events_zero(events)
    if events.nil?
      if params[:time_filter] == 'future' || params[:time_filter] == 'all'
        return 'No events yet, click on new event to create a new one'
      end
      return 'No past events, but click on the button above to create new ones' if params[:time_filter] == 'past'
    end
    nil
  end

  def invitations_owner_check(event)
    array = []
    return array if future_event?(event.date)

    array.push(render('attendees/inviteform')) if session[:user_id] == event.user_id
    invitation = event.attendees.find_by(user_id: session[:user_id])
    if event.tpeople != event.attendees.where(status: 'accepted').count && !invitation.nil?
      if invitation.status == 'pending'
        array.push(render('attendees/edit',
                          attendee: invitation))
      end
      if invitation.status == 'accepted'
        array.push(render('attendees/cancel',
                          attendee: invitation))
      end
    end
    array
  end

  def future_event?(_date)
    return true if !event.date.nil? && event.date.future?

    false
  end
end
