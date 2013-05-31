Pixtory::Application.config.secret_key_base = (ENV['SECRET_TOKEN'] || SecureRandom.hex(64))
