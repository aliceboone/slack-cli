require_relative 'test_helper'

describe "Users class" do
  describe("Users instantiation") {
    before do
      @users = SlackCli::Users.new(
          username: "Jane",
          real_name: "Jane Park",
          slack_id: "U015QQ2BXFZ"
      )
    end

    it "is a instance of Users" do
      expect(@users).must_be_kind_of SlackCli::Users
    end

    it "throws an argument error with a bad ID value" do
      expect do
        SlackCli::Users.new(username: "Jane", real_name: "Jane Park", slack_id: nil)
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

    it "turns the object id to string" do 
      expect(@users.to_s).must_equal " - Username: Jane\n"+" - Real Name: Jane Park\n"+" - Slack ID: U015QQ2BXFZ" 
    end
  }
end