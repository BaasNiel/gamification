module UsersHelper
  def options_for_teams
    Team.all.collect {|p| [ p.name, p.id ] }
  end
end
