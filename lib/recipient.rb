require 'httparty'

BASE_URL = "https://slack.com/api/"

module SlackCli
  class SlackCliError < StandardError; end
  # Create class and constructor for recipient
  class Recipient
    attr_reader :slack_id

    def initialize(slack_id)
      self.class.validate_id(slack_id)
      @slack_id = slack_id
    end

    # Request to get data from the API
    def self.load_data(specific_list)
      url = "#{BASE_URL}#{specific_list}"
      query_items = {token: ENV["SLACK_TOKEN"]}
      response = HTTParty.get(url, query: query_items)
      return response
    end

    # Validate ID
    def self.validate_id(slack_id)
      if slack_id.nil?
        raise ArgumentError, 'ID cannot be blank or less than one.'
      end
    end

    # Request to post data to the API
    def send_msg(message)
    url = "#{BASE_URL}chat.postMessage"

    response = HTTParty.post(url,
                             headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
                             body: {
                                 token: ENV["SLACK_TOKEN"],
                                 channel: slack_id,
                                 text: message
                             })
    unless response.code == 200 || response.parsed_response["ok"]
      raise SlackCli::SlackCliError, "Error: #{response.parsed_response["error"]}"
    end
    return true
    end
  end
end
