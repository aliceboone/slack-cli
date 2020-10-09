require_relative 'recipient'

# Create class and constructor for users
module SlackCli
  class Users < Recipient
    attr_reader :slack_id, :username, :real_name

    def initialize(slack_id:, username:, real_name:)
      super(slack_id)

      @username = username
      @real_name = real_name
    end

    # Define how user details will be displayed
    def details
      details_user =
      " - Slack ID: #{@slack_id}\n"+
      " - Username: #{@username}\n"+
      " - Real Name: #{@real_name}"

      return details_user
    end

    # Define how to get users data from the API using the URL
    def self.load_data
      response = super('users.list')
      user_list = []
      response["members"].each do |user|
        user_list.push(Users.new(slack_id: user["id"], username: user["name"], real_name: user["real_name"]))
      end
      return user_list
    end
  end
end
