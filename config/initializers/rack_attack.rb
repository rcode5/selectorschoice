Rack::Attack.throttle("requests by ip", limit: 5, period: 2) do |request|
  request.ip
end

