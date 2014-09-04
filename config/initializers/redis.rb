Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379, :db => 2, :password => Rails.application.secrets.redis_password)

