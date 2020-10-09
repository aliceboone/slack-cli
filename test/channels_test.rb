require_relative 'test_helper'

describe "Channels class" do #C016EHQMZ6X|csmemes| Funny Memes| 49
  before {
    @channels = SlackCli::Channels.new(
        slack_id:"U015QQ2BXFZ",
        channel_name: "csmemes",
        topic: "Funny Memes",
        member_count: 49,
    )
  }

  it "is a instance of Channel" do
    expect(@channels).must_be_kind_of SlackCli::Channels
  end

  it "throws an argument error with a bad ID" do
    expect {SlackCli::Channels.new(slack_id: nil, channel_name:"csmemes", topic:"Funny Memes",member_count: 49)
    }.must_raise ArgumentError
  end

  it "is set up for specific attributes and data types" do
    [:slack_id, :channel_name, :topic, :member_count].each do |prop|
      expect(@channels).must_respond_to prop
    end
    expect(@channels.slack_id).must_be_kind_of String
    expect(@channels.channel_name).must_be_kind_of String
    expect(@channels.topic).must_be_kind_of String
    expect(@channels.member_count).must_be_kind_of Integer
  end

  it "Correctly add details"  do
    expect(@channels.details).must_equal " - Slack ID: U015QQ2BXFZ\n"+
                                         " - Channel Name: csmemes\n"+
                                         " - Topic: Funny Memes\n"+
                                         " - Member Count: 49"
  end

  it "returns all channels" do
    VCR.use_cassette "channels_test" do
      result = SlackCli::Channels.load_data
    end
  end

  it "can send a message to the channel" do
    VCR.use_cassette("nominal-positive") do
      answer = @channels.send_msg("test message")
      expect(answer).must_equal true
    end
  end
end

