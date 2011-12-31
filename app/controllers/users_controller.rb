class UsersController < ApplicationController
  # display the dashboard
  def index
    @user = current_user
    @player = @user.has_attribute?("player") ? @user.player : nil
    @recent_rounds = @player.nil? ? [] : @player.rounds.limit(10).order('created_at DESC')
    respond_to do |format|
      if signed_in?
        format.html # index.html.erb
        format.json { render json: @user }
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
        format.html { redirect_to @user, notice: 'Player was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
