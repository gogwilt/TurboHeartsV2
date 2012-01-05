namespace :db do
  desc "Add several players with random games between them"
  task :populate => :environment do
    names = [ 'Jess', 'Cai', 'Ryan', 'Elliot', 'Pat' ]
    players = names.map {|name| Player.create(:name => name)}
    10.times do |i|
      round = Round.create(:created_at => Time.now - i.days)
      players.sample(4).each do |player|
        point = Point.new
        point.created_at = Time.now - i.days
        point.player = player
        point.round = round
        point.value = rand(80) - 40
        point.save
      end
    end
    user = User.new(:email => 'gogwilt@gmail.com', :password => 'pass', :password_confirmation => 'pass')
    player = Player.find(2)
    league = League.create(:name => "My League", :description => "A league made up of people you have played and who have played each other.", :all_players => true)
    league.players << player
    user.player = player
    user.save
  end
end