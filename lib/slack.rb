require 'dotenv'
require 'table_print'

require_relative 'workspace'
# Define method to display menu
def menu
  puts "Choose a number for the options bellow!:\n 1 - List Users\n"+" 2 - List Channels\n"+" 3 - Select user\n"+" 4 - Select channel\n"+" 5 - Details\n"+" 6 - Send a message\n"+" 7 - Exit\n"
end

def main

  Dotenv.load  # Raise an error if Key is not correct
  unless ENV["SLACK_TOKEN"]
    raise ArgumentError, "Could not load API Key"
  end
  # Define how user will see menu options and iterate with menu
  puts "***** Welcome to the Ada Slack CLI! *****"
  workspace = SlackCli::Workspace.new
  done = false
  for_detail = ""
  until done
    menu
    user_command = gets.chomp
    case user_command
    when "7"
      done = true
    when "1"
      tp workspace.all_users, "slack_id", "username", "real_name"
    when "2"
      tp workspace.all_channels, "slack_id", "channel_name", "topic", "member_count"
    when "3"
      puts "Enter a username or slack_id:"
      user_input = gets.chomp
      for_detail = workspace.selected_user(user_input)
      if for_detail.nil?
        puts "Can not find the user."
      end
    when "4"
      puts "Enter a channel name or slack_id:"
      channel_input = gets.chomp
      for_detail = workspace.selected_channel(channel_input)
      if for_detail.nil?
        puts "Can not find the channel."
      end

    when "5"
      puts for_detail.details
    when "6"
      if for_detail.nil?
        puts "Yor message can not be sent!"
      else
        puts "Please type the message you want to send!"
        send_msg_input = gets.chomp
        for_detail.send_msg(send_msg_input)
        puts "Your message was sent with success!"
      end
    else
      puts "Invalid number, try again!"
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end
main if __FILE__ == $PROGRAM_NAME