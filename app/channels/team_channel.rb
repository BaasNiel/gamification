class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'team_channel'
  end
end
