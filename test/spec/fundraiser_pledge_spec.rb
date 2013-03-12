require 'spec_helper'

describe "Fundraiser Pledges" do
  describe "create" do
    before do
      login_with_email!
      @browser.override_api_response_data("get_fundraiser", data: factory(:fundraiser))
      @browser.override_api_response_data("get_pledge", data: factory(:pledge))
      @browser.goto "#"
    end

    it "should pledge to fundraiser and select a reward" do
      # find a fundraiser card and click on it
      bounty_card = @browser.a(text: 'Pledge!')
      bounty_card.wait_until_present

      # goto_route instead of .click because it sometimes doesn't scroll enough and chatbar gets the click
      @browser.goto '#'+bounty_card.href.split('#').last


      @browser.a(text: 'Make a Pledge').when_present.click

      # make a pledge to this fundraiser
      @browser.text_field(id: 'pledge-amount').when_present.set(25)
      @browser.radio(id: 'payment_method_paypal').click

      # select a reward
      @browser.div(id: 'fundraiser-rewards').divs.first.click

      @browser.button(value: 'Continue to Payment').click

      # assume paypal is good
      # proceed_through_paypal_sandbox_flow!

      @browser.goto('#fundraisers/1/pledges/1/receipt')

      @browser.h2(text: /\$\d+\s+pledge\s+made/i).wait_until_present
    end
  end
end