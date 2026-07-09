require "test_helper"

class JwtServiceTest < ActiveSupport::TestCase
  test "encodes and decodes a payload" do
    payload = { "sub" => "user@example.com" }

    token = JwtService.encode(payload)
    decoded = JwtService.decode(token)

    assert_not_nil token
    assert_equal payload["sub"], decoded["sub"]
  end

  test "returns nil for an expired token" do
    token = JwtService.encode({ "sub" => "user@example.com", "exp" => 1.hour.ago.to_i })

    assert_nil JwtService.decode(token)
  end
end
