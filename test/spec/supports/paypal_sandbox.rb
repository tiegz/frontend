def proceed_through_paypal_sandbox_flow!
  # log in to master account if necessary
  @browser.a(text: /(PayPal Sandbox|User Agreement)/).wait_until_present
  if @browser.a(text: 'PayPal Sandbox').present?
    url = @browser.url

    master_credentials = CREDENTIALS["paypal"]["master"]
    @browser.goto "https://developer.paypal.com/"
    @browser.input(id: 'login_email').wait_until_present
    @browser.input(id: 'login_email').send_keys(master_credentials["email"])
    @browser.input(id: 'login_password').send_keys(master_credentials["password"])
    @browser.button(value: 'Log In').click
    @browser.a(text: 'preconfigured account').wait_until_present

    @browser.goto(url)
  end

  if @browser.button(name: 'login_button').present?
    @browser.button(name: 'login_button').click
  end


  @buyer_credentials = CREDENTIALS["paypal"]["buyer"]

  @browser.text_field(id: 'login_email').wait_until_present
  @browser.text_field(id: 'login_email').set(@buyer_credentials["email"])
  @browser.text_field(id: 'login_password').set(@buyer_credentials["password"])
  @browser.button(id: 'submitLogin').click

  @browser.checkbox(id: 'esignOpt').wait_until_present
  sleep 1
  @browser.checkbox(id: 'esignOpt').click
  @browser.button(id: 'agree').click

  @browser.button(id: 'continue_abovefold').wait_until_present
  sleep 1
  @browser.button(id: 'continue_abovefold').click

  @browser.button(name: 'merchant_return_link').wait_until_present
  sleep 1
  @browser.button(name: 'merchant_return_link').click

  Watir::Wait.until { @browser.execute_script("return (typeof(scope) != 'undefined') && scope.instance && scope.instance.initializer && (typeof(scope.__initializers) == 'undefined')") }
end