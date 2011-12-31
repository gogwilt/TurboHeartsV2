class SessionsController < ApplicationController
  def new
    @do_not_show_sign_in_info = true
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                           params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @do_not_show_sign_in_info = true
      render 'new'
    else
      sign_in user
      redirect_to dashboard_path
    end
  end
  
  def destroy
    sign_out
    redirect_to players_path
  end

end
