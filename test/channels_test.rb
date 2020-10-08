require_relative 'test_helper'

describe "Channels class" do
  describe "Channels instantiation" do
    before {
      @channels = SlackCli::Channels.new(
          channel_name: "csmemes",
          topic: "Funny Memes",
          member_count: 104,
          slack_id: "C016EHQMZ6X"
      )
    }

    it "is a instance of Channel" do
      expect(@channels).must_be_kind_of SlackCli::Channels
    end

    it "throws an argument error with a bad ID" do
      expect {SlackCli::Channels.new(channel_name:"csmemes", topic:"Funny Memes",member_count: 104, slack_id: nil)
      }.must_raise ArgumentError
    end

    it "is set up for specific attributes and data types" do
      [:channel_name, :topic, :member_count, :slack_id].each do |prop|
        expect(@channels).must_respond_to prop
      end

      expect(@channels.channel_name).must_be_kind_of String
      expect(@channels.topic).must_be_kind_of String
      expect(@channels.member_count).must_be_kind_of Integer
      expect(@channels.slack_id).must_be_kind_of String
    end

    it "turns the object id to string" do 
      expect(@channel_name.to_s).must_equal " - Channel Name: csmemes\n"+" - Topic: Funny Memes\n"+          
      " - Number of members: 104\n"+" - Slack ID: C016EHQMZ6X"
    end
  end
end
