require 'rubygems'
require 'bundler/setup'

require 'selenium-webdriver'
require 'service_manager'


desc 'Run Jasmine tests with Phantomjs'
task :phantomjs do
  # Note: we are assuming phantomjs is installed and available in $PATH
  sh %{phantomjs lib/phantom-jasmine/run_jasmine_test.coffee SpecRunner.html}
end


desc 'Run Jasmine tests with Webdriver'
task :webdriver do
  # Use service_manager to start a simple web server
  ServiceManager.start

  # Detect which browser we want to run
  case ENV['browser']
  when 'chromium'
    # TODO: detect chromium path? I use Linux, this is the path on my machine
    Selenium::WebDriver::Chrome.path = '/usr/lib/chromium-browser/chromium-browser'
    driver = Selenium::WebDriver.for :chrome
  when 'firefox'
    driver = Selenium::WebDriver.for :firefox
  else
    raise ArgumentError, 'Unknown browser requested'
  end

  # Finally, we load the spec runner HTML page with WebDriver
  driver.navigate.to 'http://localhost:8000/SpecRunner.html'
  status = driver.execute_script('return consoleReporter.status;')
  output = driver.execute_script('return consoleReporter.getLogsAsString();')
  driver.quit

  print output

  # Make sure to exit with code > 0 if there is a test failure
  raise RuntimeError, 'Failure' unless status === 'success'

end