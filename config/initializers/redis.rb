uri = URI.parse(ENV["REDISTOGO_URL"] || "http://localhost:6789")
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
