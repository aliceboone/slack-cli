require_relative 'test_helper'
describe "Recipient class" do

    it 'takes and saves an id' do
      id = "USLACKBOT"
      record = SlackCli::Recipient.new(id)
      expect(record.slack_id).must_equal id
    end

  it "can be initialized" do
    VCR.use_cassette("recipient-load-data") do
      response = SlackCli::Recipient.load_data('users.list')
      expect(response.code).must_equal 200
      expect(response.parsed_response["ok"]).must_equal true
    end
  end

  it 'validates an ID' do
    [nil].each do |id|
      expect {
        SlackCli::Recipient.validate_id(id)
      }.must_raise ArgumentError
    end
  end
end


