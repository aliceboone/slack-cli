require 'dotenv'

require_relative 'workspace'

def menu
  puts "Choose the number of options you can see!:\n 1 - List Users\n"+" 2 - List Channels\n"+" 3 - Select user\n"+" 4 - Select channel\n"+" 5 - Details\n"+" 6 - Exit\n"
end

def main

  Dotenv.load

  # Raise an error if Key is not correct
  unless ENV["SLACK_TOKEN"]
    raise ArgumentError, "Could not load API Key"
  end

  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCli::Workspace.new
  done = false
  for_detail = ""
  until done
    menu
    user_command = gets.chomp
    case user_command
    when "6"
      done = true
    when "1"
      td   workspace.all_users
    when "2"
      td workspace.all_channels
    when "3"
      puts "Enter a username or slack_id:"
      user_input = gets.chomp
      for_detail = workspace.selected_user(user_input)
    when "4"
      puts "Enter a channel name or slack_id:"
      channel_input = gets.chomp
      for_detail = workspace.selected_channel(channel_input)
    when "5"
      puts for_detail.to_s
    else
      puts "Invalid number, try again!"
    end
  end
end


main if __FILE__ == $PROGRAM_NAME