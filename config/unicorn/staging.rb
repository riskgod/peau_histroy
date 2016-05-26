worker_processes 1
timeout 30

@app_path = File.expand_path('../../../../../', __FILE__)
listen "/tmp/shop_staging.sock", :backlog => 64
pid "#{@app_path}/tmp/pids/unicorn.pid"
stderr_path "#{@app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{@app_path}/shared/log/unicorn.stdout.log"
