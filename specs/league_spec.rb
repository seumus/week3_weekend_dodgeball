require('minitest/autorun')
require_relative('../models/league.rb')
require_relative('../models/match.rb')
require_relative('../models/team.rb')
require_relative('../db/sql_runner.rb')

class TestLeague < Minitest::Test

  def setup

    Team.delete_all()
    Match.delete_all()

    team1 = Team.new('name' => 'Duckers', 'location' => 'Edinburgh')
    team2 = Team.new('name' => 'Dodgers', 'location' => 'Glasgow')
    team3 = Team.new('name' => 'Dippers', 'location' => 'Aberdeen')
    team4 = Team.new('name' => 'Divers', 'location' => 'Inverness')

    @t1 = team1.save()
    @t2 = team2.save()
    @t3 = team3.save()
    @t4 = team4.save()

    @teams = [@t1,@t2,@t3,@t4]

    match1 = Match.new('home_team_score' => 50, 'away_team_score' => 40, 'home_team_id' => @t1.id, 'away_team_id' => @t2.id)
    match2 = Match.new('home_team_score' => 30, 'away_team_score' => 50, 'home_team_id' => @t3.id, 'away_team_id' => @t4.id)
    match3 = Match.new('home_team_score' => 50, 'away_team_score' => 60, 'home_team_id' => @t1.id, 'away_team_id' => @t4.id)
    @m1 = match1.save()
    @m2 = match2.save()
    @m3 = match3.save()
    @matches = [@m1, @m2, @m3]

    @league = League.new(@teams,@matches)
  end

  def test_round_wins()
    result = @league.round_winners
    assert_equal([@t1.id,@t4.id,@t4.id], result)
  end

  def test_league_winner()
    result = @league.league_winner()
    assert_equal("Divers", result)
  end

  def test_runner_up()
    result = @league.runner_up()
    assert_equal("Duckers", result)
  end

end
