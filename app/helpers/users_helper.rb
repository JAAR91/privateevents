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
end
