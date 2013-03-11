require 'spec_helper'

describe "Signin" do
  let(:valid_email) { "john.doe@email.com" }
  let(:valid_password) { "123456" }

  before do
    @browser.goto '#signin/email'
  end

  describe "email/password login" do
    describe "check email" do
      before do
        @browser.override_api_response_data("login", data: factory(:registered_user))
      end

      it "should test if email exists" do
        form = @browser.section(id: 'content').form
        form.text_field(name: 'email').set(valid_email)
        form.text_field(name: 'password').set(valid_password)
        form.div(text: /Email address found/).wait_until_present
        form.button.click

        @browser.span(id: 'user_nav_name').wait_until_present
      end
    end

    describe 'check password' do
      before do
        @browser.override_api_response_data("login", data: factory(:registered_user), status: 404)
      end
      it "should show password reset link when email/password are wrong" do
        form = @browser.section(id: 'content').form
        form.text_field(name: 'email').set(valid_email)
        form.text_field(name: 'password').set('wrong-password')
        form.div(text: /Email address found/).wait_until_present
        form.button.click

        @browser.a(text: /reset your password via email/).wait_until_present
      end
    end
  end

  # it "should reset password with code" do

  # end

  describe 'registration' do
    before do
      @browser.override_api_response_data("login", data: factory(:unregistered_user), status: 404)
    end
    it "should create an account with email/password, enter optional fields" do
      form = @browser.section(id: 'content').form
      form.text_field(name: 'email').set(valid_email)
      form.text_field(name: 'password').set(valid_password)
      form.div(text: /Email address not yet registered/).wait_until_present

    end
  end

  describe 'login' do
    before do
      @browser.override_api_response_data("login", data: factory(:registered_user))
    end
    it "should sign in valid user" do
      form = @browser.section(id: 'content').form
      form.text_field(name: 'email').set(valid_email)
      form.text_field(name: 'password').set(valid_password)
      form.button.click

      # wait until we're logged in
      @browser.span(id: 'user_nav_name', text: 'john.doe').wait_until_present

      # logout
      @browser.span(id: 'user_nav_name').hover
      @browser.a(text: 'Logout').click
      @browser.a(text: 'Sign In').wait_until_present
    end
  end

  # it "should link with github and create a new account" do
  #   @browser.goto '#'
  #   @browser.a(text: 'Sign In').when_present.click
  #   @browser.a(text: 'GitHub').click
  #   @browser.span(id: 'user_nav_name', text: CREDENTIALS["github"]["username"]).wait_until_present
  # end
end
