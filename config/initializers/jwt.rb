JWT_CONFIG = Rails.application.config_for(:jwt)

JWT_SECRET = JWT_CONFIG["secret_key"]