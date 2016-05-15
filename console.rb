require('pry-byebug')
require_relative('models/team.rb')
require_relative('models/match.rb')

Team.delete_all()
Match.delete_all()


team1 = Team.new('name' => 'Duckers', 'location' => 'Edinburgh')
team2 = Team.new('name' => 'Dodgers', 'location' => 'Glasgow')

t1 = team1.save()
t2 = team2.save()

match1 = Match.new('home_team_score' => 50, 'away_team_score' => 40, 'home_team_id' => t1.id, 'away_team_id' => t2.id)
m1 = match1.save()

binding.pry
nil
