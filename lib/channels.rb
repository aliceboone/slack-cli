require_relative 'recipient'

module SlackCli
  class Channels < Recipient
    attr_reader :channel_name, :topic, :member_count, :slack_id

    def initialize(channel_name:, topic:, member_count:, slack_id:)
      super (slack_id)

      @channel_name = channel_name
      @topic = topic
      @member_count = member_count.to_i
    end
    def to_s
      details_channel =          
      " - Channel Name: #{@channel_name}\n"+          
      " - Topic: #{@topic}\n"+          
      " - Number of members: #{@member_count}\n"+          
      " - Slack ID: #{@slack_id}"      
      return details_channel
    end

    private
    def self.load_data
      response = super('conversations.list')
      channel_list = []
      response["channels"].each do |channel|
        channel_list.push(Channels.new(channel_name: channel["name"], topic: channel["topic"]["value"], member_count: channel["num_members"].to_i, slack_id: channel["id"]))
      end
      return channel_list
    end
  end
end

