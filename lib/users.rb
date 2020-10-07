require_relative 'recipient'

module SlackCli
  class Users < Recipient
    attr_reader :username, :real_name, :slack_id

    def initialize(username:, real_name:, slack_id:)
      super(slack_id)

      @username = username
      @real_name = real_name
    end

    private
    def self.load_data
      response = super('users.list')
      user_list = []
      response["members"].each do |user|
        user_list.push(Users.new(username: user["name"], real_name: user["real_name"], slack_id: user["id"]))
      end
      return user_list
    end


  end
end
