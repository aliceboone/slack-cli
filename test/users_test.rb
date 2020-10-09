require_relative 'test_helper'

describe "Users class" do

  before {
    @users = SlackCli::Users.new(
        username: "slackbot",
        real_name: "Slackbot",
        slack_id: "USLACKBOT"
    )
  }

  it "is a instance of Users" do
    expect(@users).must_be_kind_of SlackCli::Users
  end

  it "throws an argument error with a bad ID value" do
    expect do
      SlackCli::Users.new(username: "slackbot", real_name: "Slackbot", slack_id: nil)
          .must_raise ArgumentError
    end
  end

  it "is set up for specific attributes and data types" do
    [:username, :real_name, :slack_id].each do |prop|
      expect(@users).must_respond_to prop
    end

    expect(@users.username).must_be_kind_of String
    expect(@users.real_name).must_be_kind_of String
    expect(@users.slack_id).must_be_kind_of String
  end

  it "returns all users" do
    VCR.use_cassette "users_test" do
      result = SlackCli::Users.load_data
    end
  end

  it "Correctly add details"  do
    expect(@users.details).must_equal " - Slack ID: USLACKBOT\n"+
                                      " - Username: slackbot\n"+
                                      " - Real Name: Slackbot"
  end

  " - Username: #{@username}\n"+
      " - Real Name: #{@real_name}\n"+
      " - Slack ID: #{@slack_id}"

  it "can send a message to the user" do
    VCR.use_cassette("nominal-positive") do
      answer = @users.send_msg("test message")
      expect(answer).must_equal true
    end
  end
end
