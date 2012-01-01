class UsersController < ApplicationController
  # display the dashboard
  def index
    respond_to do |format|
      if signed_in?
        @user = current_user
        @player = @user.player
        @recent_rounds = @player.nil? ? [] : @player.rounds.limit(10).order('created_at DESC')
        format.html # index.html.erb
      else
        format.html { redirect_to signin_path }
      end
    end
  end

  
  def new 
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to dashboard_path, notice: 'Player was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
