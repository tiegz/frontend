require "bundler"
require "ostruct"
Bundler.require
Dir[File.dirname(__FILE__) + "/supports/**/*.rb"].each {|f| require f}

CREDENTIALS = YAML.load_file(File.expand_path('../../config/credentials.yml', __FILE__))
MOCK_API = ENV['MOCK_API'] || true

if ENV['RAILS_ENV'] == 'staging'
  BASE_URL = 'https://www-qa.bountysource.com/'
  API_ENDPOINT = 'qa'
  DEMO_MODE = false
else
  # BASE_URL = 'https://www-qa.bountysource.com/'
  # API_ENDPOINT = 'qa'
  BASE_URL = if MOCK_API
    'file://' + File.expand_path('../../../test.html', __FILE__)
  else
    'http://www.bountysource.dev'
  end
  API_ENDPOINT = 'dev'
  DEMO_MODE = false
end

# matches money.
RSpec::Matchers.define :match_money do |value|
  match do |value|
    parts = value.to_f.to_s.split('.')
    parts[1] = (parts[1]+'0')[0..1]
    regex = Regexp.new(parts.length == 2 ? "^\$?#{parts[0]}\.#{parts[1]}$" : "^\$?#{parts[0]}$")
    !!((parts.join('.')). =~ regex)
  end
end

RSpec.configure do |config|
  config.before(:all) do
    if MOCK_API
      # inject mock_api.js to mock out all API calls
      cmd = 'sed "s/<\/head>/<script src=\"test\/javascripts\/mock_api.js\"><\/script><\/head>/g" ' + File.dirname(__FILE__) + '/../../index.html > ' + File.dirname(__FILE__) + '/../../test.html'
      `#{cmd}`
    end
  end

  config.after(:all) do
    if MOCK_API
      # remove test html file
      `rm -f #{File.dirname(__FILE__) + '/../../test.html'}`
    end
  end
  config.before(:suite) do
    user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.56 Safari/537.17 Selenium'
    if ENV['RAILS_ENV'] == 'staging'
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('chrome.switches' => ["--user-agent='#{user_agent}'"])
      $browser = Watir::Browser.new(:remote, :url => 'http://165.225.134.232:9515/', :desired_capabilities => capabilities)
    else
      $browser = Watir::Browser.new(:chrome, :switches => ["--user-agent='#{user_agent}'"])
    end

    # add a navigate method for scope.js routes
    class << $browser
      # execute javascript in the scope.js instance
      def execute_scopejs_script(src)
        Watir::Wait.until { execute_script("return (typeof(scope) != 'undefined') && scope.instance && scope.instance.initializer && (typeof(scope.__initializers) == 'undefined')") }
        execute_script "with (scope.instance) { #{src} }"
      end

      alias_method :goto_without_scope, :goto
      def goto(route)
        if !(route =~ /^#/)
          # absolute URL
          goto_without_scope(route)
        elsif url[0, BASE_URL.length] == BASE_URL
          # scope route and we're already on a scope page
          execute_scopejs_script "set_route('#{route}');"
        else
          # scope route but we're not on a scope page
          goto_without_scope("#{BASE_URL}#{route}")
        end

        if ((MOCK_API && BASE_URL =~ /test\.html/) || (MOCK_API && BASE_URL =~/bountysource\.dev/)) && route =~ /^#/
          $browser.div(id: 'dev-bar').wait_until_present
          if $browser.div(id: 'dev-bar').a(text: API_ENDPOINT).exists?
            $browser.div(id: 'dev-bar').a(text: API_ENDPOINT).click
            $browser.div(id: 'dev-bar').b(text: API_ENDPOINT).wait_until_present
          end
        end
      end

      def mock_api!
        execute_scopejs_script %(
          with (scope('BountySource')) {
            define('_original_api', api);
            define('api', function() { console.log('API CALLED', arguments) });
          }
        )
      end

      def restore_api!
        execute_scopejs_script %(
          with (scope('BountySource')) {
            define('api', _original_api);
            delete BountySource._original_api;
          }
        )
      end

      # override an API method. results of block will be passed as response.data
      def override_api_response_data(method, options={})
        return unless MOCK_API

        # if not status provided, use success to make it 200 or 400
        status  = options[:status].nil? ? 200 : options[:status]
        success = options[:success].nil? ? true && status == 200 : options[:success]

        execute_scopejs_script %(
          with (scope('BountySource')) {
            define('_original_#{method}', #{method});
            define('#{method}', function() {
              var response = { data: #{options[:data].to_json}, meta: { status: #{status}, success: #{success} } };
              // parse the URL string from the function
              var url_str = BountySource._original_#{method}.toString().match(/api.([^\,]+)\,/)[1].replace(/[',",\s]/g, '');

              // match the argument patterns
              var url_arguments = url_str.match(/(\\\+[^+\/]+)/g);
              if(url_arguments) {
                // replace argument into the url string
                for(var i = 0; i < url_arguments.length; i++) {
                  url_str = url_str.replace(url_arguments[i], arguments[i]);
                }
              }

              url_str = url_str.replace(/\\\+/g, '');

              // save the mock response for each generated url
              scope.jsonp_mock_responses[url_str] = response;
              BountySource._original_#{method}.apply(this, arguments);
            });
          }
        )
      end

      # restore a method that was previously mocked
      def restore_api_method(*methods)
        methods.each do |method|
          execute_scopejs_script %(
            with (scope('BountySource')) {
              define('#{method.to_s}', _original_#{method.to_s});
              delete BountySource._original_#{method.to_s};
            }
          )
        end
      end

      # a breakpoint that halts testing until browser window clicked.
      def breakpoint!(text='Click anywhere to continue...', timeout=0)
        puts ">> breakpoint reached. click anywhere in the browser to continue"

        text = text.gsub("\"", "\\\"")

        execute_scopejs_script %(
          document.body.appendChild(div(
            {
              id: '_breakpoint_overlay',
              style: 'background-color: rgba(0, 0, 0, 0.6); position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 10; text-align: center;',
              onClick: function() { App.remove_element('_breakpoint_overlay'); }
            },
            p({ style: 'margin: 150px 100px; line-height: 60px; font-size: 50px; color: white; text-shadow: 3px 3px #000' }, "#{text}"))
          );
          if (#{timeout} > 0) setTimeout(function() {
            var e = document.getElementById('_breakpoint_overlay');
            e.parentNode.removeChild(e);
          }, #{timeout});
          console.log("** Breakpoint reached **");
         )

        while execute_scopejs_script("return document.getElementById('_breakpoint_overlay');") do
          sleep 0.25 # waiting a little
        end

        puts ">> continuing from breakpoint"
      end
    end
  end

  config.before(:all) do
    @browser = $browser

    login_with_github!
  end

  config.before(:each) do
    $browser.goto '#' unless $browser.url =~ /\#$/
    $browser.execute_scopejs_script "BountySource.logout();"
  end

  config.before(:each) do |test|
    if DEMO_MODE
      $browser.breakpoint!(test.example.metadata[:full_description], 4000)
    end
  end

  config.after(:suite) do
    $browser.close
  end
end