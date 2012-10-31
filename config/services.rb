# Simple service_manager configuration for a local webserver
# used to host the Jasmine spec runner
ServiceManager.define_service "spec_runner" do |s|
    s.start_cmd = "python -m SimpleHTTPServer"
    s.loaded_cue = /Serving HTTP/
    s.cwd = Dir.pwd
    s.pid_file = "spec_runner.pid"
end
