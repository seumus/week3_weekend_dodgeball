require('pg')
require_relative('../db/sql_runner.rb')

class Match

  attr_reader(:id)
  attr_accessor(:away_team_score,:home_team_score,:away_team_id,:home_team_id)

  def initialize(options)
    @id = options['id'].to_i
    @away_team_score = options['away_team_score'].to_i
    @home_team_score = options['home_team_score'].to_i
    @away_team_id = options['away_team_id'].to_i
    @home_team_id = options['home_team_id'].to_i
  end

  def save()
    sql = "INSERT INTO matches (away_team_score,home_team_score,away_team_id,home_team_id) VALUES (#{@away_team_score}, #{@home_team_score}, #{@away_team_id}, #{@home_team_id}) RETURNING *;"
    return Match.map_item(sql)
  end

  def self.map_items(sql)
    matches = SqlRunner.run(sql)
    result = matches.map {|match| Match.new(match)}
    return result
  end

  def self.map_item(sql)
    result = Match.map_items(sql)
    return result.first
  end

  def self.delete_all
    sql = "DELETE FROM matches"
    SqlRunner.run(sql)
  end

  def winner()
    if @home_team_score > @away_team_score
       @home_team_id
    else
       @away_team_id
    end
  end

  def loser()
    if @home_team_score > @away_team_score
       @away_team_id
    else
       @home_team_id
    end
  end

  # def winner()
  #
  # end


end
