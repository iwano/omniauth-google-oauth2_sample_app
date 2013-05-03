class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    notice = login_or_create_user auth
    signed_in_redirect notice
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  private

    def create_user(auth)
      User.create uid: auth["uid"],
            name: auth["info"]["name"],
            email: auth['info']['email'],
            pic_url: auth['info']['image']
    end

    def login_or_create_user(auth)
      notice = ''
      user = User.where(uid: auth["uid"])
      if user == []
        if valid_domain auth['info']['email']
          user = create_user auth
          notice = "Welcome  #{user.name}"
          session[:user_id] = user.id
        else
          notice = "Only accounts under the crowdint domain are allowed"
        end
      else
        user = user.first
        notice = "Logged in as #{user.name}"
        session[:user_id] = user.id
      end
      notice
    end

    def valid_domain(email) #restrict access to specific domain
      email =~ /@crowdint.com$/
    end

    def signed_in_redirect(notice)
      redirect_to root_url, :notice => notice
    end
end