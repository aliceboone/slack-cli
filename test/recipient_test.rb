require_relative 'test_helper'
describe "Recipient class" do

  describe "Response request" do
    it "can be initialized" do
      VCR.use_cassette("recipient-load-data") do
        response = SlackCli::Recipient.load_data('users.list')
        expect(response.code).must_equal 200
        expect(response.parsed_response["ok"]).must_equal true
      end
    end
  end
end


