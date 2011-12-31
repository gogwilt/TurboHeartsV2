namespace :db do
  desc "Add several players with random games between them"
  task :populate => :environment do
    names = [ 'Jess', 'Cai', 'Ryan', 'Elliot', 'Pat' ]
    players = names.map {|name| Player.create(:name => name)}
    10.times do
      round = Round.create
      players.sample(4).each do |player|
        point = Point.new
        point.player = player
        point.round = round
        point.value = rand(80) - 40
        point.save
      end
    end
  end
end