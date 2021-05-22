module AttendeesHelper
  def invitations_owner_check(event)
    array = []
    if session[:user_id] == event.user_id
      array.push(render('attendees/inviteform'))
      array.push(render('attendees/invitations'))
    end
    invitation = event.attendees.find_by(user_id: session[:user_id])
    if event.tpeople != event.attendees.where(status: 'accepted').count && !invitation.nil?
      array.push(render('attendees/edit', attendee: invitation)) if invitation.status == 'pending'
      array.push(render('attendees/cancel', attendee: invitation)) if invitation.status == 'accepted'
    end
    array
  end

  def status_messages(event)
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
    if attendee.event.date.future?
      'list-group-item-success'
    else
      'list-group-item-dark'
    end
  end
end
