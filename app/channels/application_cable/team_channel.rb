class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'team'
  end
end
