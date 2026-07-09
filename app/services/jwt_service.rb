class JwtService
  SECRET_KEY = Rails.application.secret_key_base
  ALGORITHM = "HS256"

  class << self
    def encode(payload, exp: 24.hours.from_now)
      payload = payload.dup
      payload["exp"] = exp.to_i if exp.present?
      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM).first
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
      nil
    end
  end
end
