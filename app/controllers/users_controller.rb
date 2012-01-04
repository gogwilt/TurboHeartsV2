class UsersController < ApplicationController
  # display the dashboard
  def index
    respond_to do |format|
      if signed_in?
        @user = current_user
        @player = @user.player
        @show_form_for_points = true
        @league_players = @player.players_in_clique
        @recent_rounds = @player.nil? ? [] : @player.rounds.limit(10).order('created_at DESC')
        format.html # index.html.erb
      else
        format.html { redirect_to signin_path }
      end
    end
  end

  
  def new 
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
  def create
    @user = User.new(params[:user])
    player = Player.new(params[:player])
    @user.player = player

    respond_to do |format|
      if @user.save
        player.save
        sign_in @user
        format.html { redirect_to dashboard_path, notice: 'Player was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def new_round
    round = Round.create
    (1..4).each do |i|
      player_name = params["player#{i}_name"]
      player_score = params["player#{i}_score"]
      player = create_or_find_player_by_name player_name
      point = Point.new
      point.value = player_score
      point.round = round
      point.player = player
      point.save    
    end
    
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { render :json => round }
    end
  end
  
  private
  def create_or_find_player_by_name(player_name)
    player = Player.find_by_name(player_name)
    if player.nil?
      player = Player.create(:name => player_name)
    end
    player
  end
end
