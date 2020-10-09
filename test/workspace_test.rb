require_relative 'test_helper'

describe "Workspace class" do
  describe "Workspace instantiation" do

    it "The users is an array" do
      VCR.use_cassette("initialized-workspace-users") do
        response = SlackCli::Workspace.new
        expect(response.users).must_be_kind_of Array
      end
    end

    it "The channel is an array" do
      VCR.use_cassette("initialized-workspace-channels") do
        response = SlackCli::Workspace.new
        expect(response.channels).must_be_kind_of Array
      end
    end

    it "It is selecting the right user" do
      VCR.use_cassette("select user") do
        response = SlackCli::Workspace.new
        select_user = response.selected_user("slackbot")
        expect(select_user).must_be_kind_of SlackCli::Users
      end
    end

    it "It is selecting the right channel" do
      VCR.use_cassette("select channel") do
        response = SlackCli::Workspace.new
        select_channel = response.selected_channel("general")
        expect(select_channel).must_be_kind_of SlackCli::Channels
      end
    end
  end
end