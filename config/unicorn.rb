module Rails
  class <<self
    def root
      File.expand_path(__FILE__).split('/')[0..-3].join('/')
    end
  end
end

rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes (rails_env == 'production' ? 5 : 1)
preload_app true
working_directory Rails.root
listen "/tmp/woji.sock" #, :backlog => 64
listen 5000, :tcp_nopush => false
timeout 30
pid  "#{Rails.root}/tmp/pids/unicorn.pid"

stderr_path "#{Rails.root}/log/unicorn/unicorn.stderr.log"
stdout_path "#{Rails.root}/log/unicorn/unicorn.stdout.log"

# REE
# if GC.respond_to?(:copy_on_write_friendly=)
#  GC.copy_on_write_friendly = true
# end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
    
  old_pid ="#{Rails.root}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |server, worker|
 defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{Rails.root}/Gemfile"
end
  

