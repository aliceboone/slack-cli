require_relative 'recipient'

module SlackCli
  # Create class and constructor for channels
  class Channels < Recipient
    attr_reader :slack_id, :channel_name, :topic, :member_count

    def initialize(slack_id:, channel_name:, topic:, member_count:)
      super (slack_id)

      @channel_name = channel_name
      @topic = topic
      @member_count = member_count.to_i
    end

    # Define how channel details will be displayed
    def details
      details_channel =
      " - Slack ID: #{@slack_id}\n"+
      " - Channel Name: #{@channel_name}\n"+
      " - Topic: #{@topic}\n"+          
      " - Member Count: #{@member_count}"
      return details_channel
    end

    # Define how to get channel data from the API using the URL
    def self.load_data
      response = super('conversations.list')
      channel_list = []
      response["channels"].each do |channel|
        channel_list.push(Channels.new(slack_id: channel["id"], channel_name: channel["name"], topic: channel["topic"]["value"], member_count: channel["num_members"].to_i))
      end
      return channel_list
    end
  end
end

