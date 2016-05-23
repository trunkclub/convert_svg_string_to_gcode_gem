module Helpers

  def now
    Time.parse("2013-01-01T00:00:00Z")
  end

  def stubs_time
    allow(Time).to receive(:now).and_return(now)
  end

  def client
    api_client
  end

  def api_client
    # Fail if the clients receive unexpected messages, stubbing is expected in specs
    @client ||= double
  end

  def build_response(payload, status=200)
    double(status: status, body: payload.to_json)
  end

  def service_fails_unexpectedly(http_verb, error_payload={message: "Oh snap!"})
    allow(client).to receive(http_verb).and_return(build_response(error_payload, 500))
  end

  def last_json
    last_response.body
  end

  def response_payload
    JSON.parse(last_json)
  end

end
