rails_root = `pwd`.chomp
workers 2
threads(0, 16)
bind      "unix:#{rails_root}/tmp/sockets/puma.sock"
pidfile     "#{rails_root}/tmp/pids/puma.pid"
stdout_redirect "#{rails_root}/log/stdout", "#{rails_root}/log/stderr"
stdout_redirect "#{rails_root}/log/stdout", "#{rails_root}/log/stderr", true
activate_control_app
