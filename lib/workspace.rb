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

    def selected_user(user_input)
      user_by_name = @users.find {|user| user.username == user_input}
      user_by_id = @users.find {|user| user.slack_id == user_input}
      if  user_by_name != nil
        @selected_user = user_by_name
      elsif user_by_id != nil
        @selected_user = user_by_id
      end
      return
      @selected_user
      end
    def selected_channel(channel_input)
      channel_by_name = @users.find {|channel| channel.channel_name == channel_input}
      channel_by_id = @users.find {|channel| channel.slack_id == channel_input}
      if  channel_by_name != nil
        @selected_channel= channel_by_name
      elsif channel_by_id != nil
        @selected_channel = channel_by_id
      end
      return
      @selected_channel
    end
  end
end
