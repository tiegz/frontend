require "spec_helper"

describe "Bounty Creation" do
  before do
    @browser.goto '#'
  end
  describe "on issue" do
    let(:redirect_url) { '#issues/1/bounties/1/receipt' }
    describe "logged in" do
      before do
        @browser.override_api_response_data("get_issue", data: factory(:issue))
        @browser.override_api_response_data("make_payment", data: {redirect_url: redirect_url})
        @browser.override_api_response_data("get_bounty", data: factory(:bounty))

        @browser.goto "#"

        # find a bounty card and click on it
        bounty_card = nil
        @browser.div(class: 'card').wait_until_present

        # search through all cards until a bounty card is found
        @browser.divs(class: 'card').each do |e|
          if e.text =~ /Back this!/i
            bounty_card = e
            break
          end
        end
        bounty_card.click
      end

      it "should show bounty data" do
        # fill in bounty amount, select paypal and submit bounty create
        bounty_input = @browser.input(id: 'amount-input').when_present
        @browser.radio(id: 'payment_method_paypal').when_present.click
        bounty_input.send_keys 25
        @browser.button(value: 'Create Bounty').click

        @browser.goto redirect_url

        @browser.h2(text: /\$\d+\s+bounty\s+placed/i).wait_until_present
      end
    end
  end

  describe "not logged in" do
    let(:redirect_url) { '#issues/1/bounties/1/receipt' }
    describe "logged in" do
      before do
        @browser.override_api_response_data("get_issue", data: factory(:issue))
        @browser.override_api_response_data("make_payment", data: {redirect_url: redirect_url}, status: 401)
        @browser.override_api_response_data("get_bounty", data: factory(:bounty))

        @browser.goto "#"
        # find a bounty card and click on it
        bounty_card = nil
        @browser.div(class: 'card').wait_until_present

        # search through all cards until a bounty card is found
        @browser.divs(class: 'card').each do |e|
          if e.text =~ /Back this!/i
            bounty_card = e
            break
          end
        end
        bounty_card.click
      end

      it "should redirect_to login form" do
        # fill in bounty amount, select paypal and submit bounty create
        bounty_input = @browser.input(id: 'amount-input').when_present
        @browser.radio(id: 'payment_method_paypal').when_present.click
        bounty_input.send_keys 25
        @browser.button(value: 'Create Bounty').click
        @browser.a(text: 'Email Address').wait_until_present
      end
    end
  end
end