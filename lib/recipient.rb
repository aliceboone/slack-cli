require 'httparty'

BASE_URL = "https://slack.com/api/"

module SlackCli
  class Recipient
    attr_reader :slack_id

    def initialize(slack_id)
      self.class.validate_id(slack_id)
      @slack_id = slack_id
    end

    # Request(get) data from the API
    def self.load_data(specific_list)
      url = "#{BASE_URL}#{specific_list}"
      query_items = {token: ENV["SLACK_TOKEN"]}
      response = HTTParty.get(url, query: query_items)
      return response
    end

    def self.validate_id(slack_id)
      if slack_id.nil?
        raise ArgumentError, 'ID cannot be blank or less than one.'
      end
    end
  end
end
