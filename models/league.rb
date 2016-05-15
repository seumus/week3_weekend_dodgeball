require_relative('match.rb')


class League

  attr_accessor(:teams,:matches)

  def initialize(teams,matches)
    @teams = teams
    @matches = matches
  end


  def round_winners()
    winners = @matches.map do |match|
      if match.home_team_score > match.away_team_score
         match.home_team_id
      else
         match.away_team_id
      end
    end
    return winners
  end

  def league_winner()
    winner_id = round_winners.pop
    @teams.each {|team| return team.name if winner_id == team.id}
  end

  def runner_up()
    last_game = @matches.pop
    loser_id = last_game.loser()
    @teams.each {|team| return team.name if loser_id == team.id}
  end

end
