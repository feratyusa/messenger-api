require "json-schema"

module RequestSpecHelper
  # Parse JSON response to ruby hash
  def response_body
    JSON.parse(response.body)
  end

  def response_data
    response_body[:data]
  end

  def expect_response(status, schema = nil)
    begin
      expect(response).to have_http_status(status)
    rescue RSpec::Expectations::ExpectationNotMetError => e
      e.message << "\n#{JSON.pretty_generate(response_body)}"
      raise e
    end
    # expect(JSON::Validator.validate(schema, response_body)).to eq response_body
    expect(JSON::Validator.validate(schema, response_body[0] ? response_body[0] : response_body)).to eq true
  end
end
