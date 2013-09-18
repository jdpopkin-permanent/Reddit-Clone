module ApplicationHelper

  def set_current_user(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def current_user
    return nil if session[:session_token].nil?

    User.find_by_session_token(session[:session_token])
  end
end
