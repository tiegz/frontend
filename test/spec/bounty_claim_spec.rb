require 'spec_helper'

describe "Claiming a Bounty" do
  before do
    @browser.goto '#'
  end
  it "should find a bounty on the home page" do
    bounty_card = nil
    @browser.div(class: 'card').wait_until_present
    @browser.divs(class: 'card').each do |e|
      if e.text =~ /Back this!/i
        bounty_card = e
        break
      end
    end
    bounty_card.should_not be_nil
  end

  it "should find a large bounty on #bounties" do
    @browser.override_api_response_data :overview, data: factory(:bounties)
    @browser.goto "#bounties"
    @browser.div(class: 'stats').wait_until_present

    # select a link from the table after featured projects, which contains issues
    issue_links = @browser.links.select { |l| l.href =~ /#issues\/\d+/ }
    # goto_route instead of .click because it sometimes doesn't scroll enough and chatbar gets the click
    @browser.goto '#'+issue_links.sample.href

    @browser.url.should =~ /#issues\/\d+/
  end

  describe 'pull request' do
    before do
      login_with_email!
    end
    it "should see a list of pull requests after logging in" do
      @browser.override_api_response_data :get_repository_overview, data: factory(:tracker)

      @browser.goto '#trackers/4-coryboyd-bs-test'

      @browser.span(id: 'user_nav_name').wait_until_present

      @browser.override_api_response_data(:get_issue, data: factory(:issue))
      @browser.override_api_response_data :get_solutions, data: factory(:solutions)
      @browser.goto '#issues/8-test-issue-omg'

      @browser.span(id: 'user_nav_name').wait_until_present

      @browser.override_api_response_data :create_solution, data: factory(:solution)
      @browser.override_api_response_data :get_solution, data: factory(:solution)
      @browser.a(text: "Start Work").when_present.click
      @browser.h2(text: "Started a Solution").wait_until_present

      @browser.text_field(name: 'code_url').set("https://github.com/bountysource/frontend/pull/2 ")
      @browser.textarea(name: 'body').set("This is a pull request")

      @browser.override_api_response_data :submit_solution, data: {}
      @browser.override_api_response_data :get_solution, data: factory(:submitted_solution)
      @browser.input(value: 'Submit Code').click

      @browser.h2(text: "Solution Submitted!").wait_until_present
    end
  end

  describe "solutions" do
    let(:row) { @browser.table(id: 'solutions-table').rows[1] }
    before do
      login_with_email!

      # mock the user info api call to return an accepted solution
      @browser.override_api_response_data :get_solutions, data: [solution]
      @browser.override_api_response_data :get_solution, data: solution
      @browser.goto "#solutions"

      @browser.table(id: 'solutions-table').wait_until_present
      row.text.should match(expected)
      row.click
    end

    describe 'accepted' do
      let(:solution) { factory(:accepted_solution) }
      let(:expected) { /Accepted/i }
      it "should show a 'Payout' button" do
        @browser.button(text: 'Payout!').wait_until_present
      end
    end

    describe 'submitted' do
      let(:solution) { factory(:submitted_solution) }
      let(:expected) { /In Dispute Period/i }
      it "should show 'Solution Submitted!'" do
        @browser.h2(text: 'Solution Submitted!').wait_until_present
      end
    end

    describe 'disputed' do
      let(:solution) { factory(:disputed_solution) }
      let(:expected) { /Accepted/i }
      it "should show 'disputed' message if the solution is being disputed" do
        @browser.text.should match(/Solution has not yet been accepted./)
      end
    end
  end
end