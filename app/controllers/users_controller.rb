class UsersController < ApplicationController
  # display the dashboard
  def index
    respond_to do |format|
      if signed_in?
        @user = current_user
        @player = @user.player
        @show_form_for_points = true
        @league = @player.leagues[0]
        @recent_rounds = @league.nil? ? [] : @league.get_rounds.sort_by{|round| round.created_at}.reverse.first(10)
        @dashboard_view = true
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
        create_default_league_for_player player
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
    
    round.points.each do |point|
      point.calculate_dollar_value
      point.save
    end
    
    @bolded_player = current_user.player
    @round = round
    
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { render :json => round }
      format.js
    end
  end
  
  def resolve_player
    player = Player.find(params[:id])
    user = current_user
    notice_message = "Linked player scores to your account."
    if player.user
      notice_message = "This player is already owned by a user. Failed to link the player."
    else
      if share_rounds_together? user.player, player
        notice_message = "This player conflicts with some of your existing rounds. Failed to link the player."
      else
        player.points.each do |point|
          point.player = user.player
          point.save
        end
        player.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to dashboard_path, :notice => notice_message }
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
  
  def create_default_league_for_player(player)
    league = League.create(:name => "My League", :description => "A league made up of people you have played and who have played each other.", :all_players => true)
    league.players << player
  end
end
