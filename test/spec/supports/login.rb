def login_with_email!
  return if @browser.div(id: 'user-nav').present?
  @browser.override_api_response_data("login", mock_options(:registered_user))

  @bountysource_credentials = CREDENTIALS["bountysource"]

  @browser.goto "#signin/email"

  # login with email and password
  @browser.text_field(name: 'email').set(@bountysource_credentials["email"])
  @browser.text_field(name: 'password').set(@bountysource_credentials["password"])
  @browser.div(text: /Email address found/).wait_until_present
  @browser.button(value: 'Sign In').click
  @browser.div(id: 'user-nav').wait_until_present
end

def login_with_github!
  unless MOCK_API
    @browser.goto 'https://github.com/login' unless @browser.url.start_with?('https://github.com/login')

    if @browser.url.start_with?('https://github.com/login')
      github_credentials = CREDENTIALS["github"]
      @browser.text_field(id: 'login_field').set(github_credentials["username"])
      @browser.text_field(id: 'password').set(github_credentials["password"])
      @browser.button(value: 'Sign in').click

      # auto authorize
      @browser.button(text: 'Authorize app').click if @browser.button(text: 'Authorize app').present?
    end
  end
end