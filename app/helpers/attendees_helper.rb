module AttendeesHelper
  def invitations_status_top(attendees)
    return "You have no invitations #{current_user.name}" if attendees.count.zero?
  end

  def invitations_top(_attendees)
    array = []
    array.push(link_to('All events', user_attendees_path(current_user.id, time_spec: 'all'),
                       class: 'link-primary mx-2'))
    array.push(link_to('Future Events', user_attendees_path(current_user.id, time_spec: 'future'),
                       class: 'link-success mx-2'))
    array.push(link_to('Past Events', user_attendees_path(current_user.id, time_spec: 'past'), class: 'link-dark mx-2'))
    array
  end

  def status_messages(event)
    return if event.date.nil?

    if event.date < Time.now
      flash.now[:notice] =
        'This event is already over'
      return
    elsif event.tpeople == event.attendees.where(status: 'accepted').count
      flash.now[:notice] =
        'This event is not accepting any more people'
      return
    else
      status_events_message(event.attendees.find_by(user_id: session[:user_id]))
    end
    nil
  end

  def status_events_message(invitation)
    case invitation
    when 'accepted'
      flash.now[:notice] =
        'You have already accepted the invitation from this event!'
    when 'declined'
      flash.now[:notice] =
        'You have already declined the invitation from this event!'
    when 'canceled'
      flash.now[:notice] =
        'You have canceled the inviation to this event'
    when 'canceledfull'
      flash.now[:notice] =
        'This event is already full and its not accepting more people'
    end
  end

  def attedees_count(event)
    a_count = event.attendees.where(status: 'accepted')
    return 0 if a_count.nil?

    a_count.count
  end

  def list_group_color(attendee)
    return if attendee.event.date.nil?

    if attendee.event.date.future?
      'list-group-item-success'
    else
      'list-group-item-dark'
    end
  end

  def invites_checker(event)
    if event.user_id == current_user.id
      event.attendees
    else
      event.attendees.where(status: 'accepted')
    end
  end

  def attendees_del_link(event, attendees)
    if event.user_id == current_user.id
      return link_to 'Delete', user_event_attendee_path(attendees.user_id, attendees.event_id, attendees.id),
                     method: :delete, data: { confirm: 'Are you sure?' },
                     class: 'link-danger mx-2 text-decoration-none'
    end
    nil
  end

  def attendees_background_color(event, attendees)
    return if event.user_id != current_user.id
    return 'list-group-item-success' if attendees.status == 'accepted'
    return 'list-group-item-warning' if attendees.status == 'declined'
    return 'list-group-item-danger' if attendees.status == 'canceled' || attendees.status == 'canceledfull'
  end

  def attendees_title(event)
    if event.user_id == current_user.id
      if event.attendees.count.zero?
        'No invitations sent for this event'
      else
        'Invitations sent'
      end
    elsif event.attendees.where(status: 'accepted').count.zero?
      'No user have acepted an invitation to this event'
    else
      'Attendance list'
    end
  end
end
