require_relative 'channels'
require_relative 'users'

module SlackCli
  class Workspace
    attr_reader :users, :channels

    def initialize
      @users = Users.load_data
      @channels = Channels.load_data
    end

    def all_users
      return @users
    end

    def all_channels
      return @channels
    end
  end
end
