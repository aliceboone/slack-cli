require 'dotenv'

require_relative 'workspace'

def menu
  puts "Choose the number of options you can see!:\n 1 - List Users\n"+" 2 - List Channels\n"+" 3 - Exit\n"
end

def main

  Dotenv.load

  # Raise an error if Key is not correct
  unless ENV["SLACK_TOKEN"]
    raise ArgumentError, "Could not load API Key"
  end

  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCli::Workspace.new

  # TODO project
  done = false
  until done
    menu
    user_command = gets.chomp
    case user_command
    when "3"
      done = true
    when "1"
      workspace.all_users.each { |user| puts "Username: #{ user.username }, Real name: #{ user.real_name }, Slack Id: #{ user.slack_id }"}
    when "2"
      workspace.all_channels.each { |channel| puts "Channel's name: #{ channel.channel_name}, Topic: #{ channel.topic}, Member count: #{channel.member_count}, Slack Id: #{ channel.slack_id}}"}
    else
      puts "Invalid number, try again!"
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME