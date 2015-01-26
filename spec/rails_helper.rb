# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.run_all_when_everything_filtered = true

  config.after(:suite) do
    #get github issues
    repo = 'freddyrangel/snitch-example'
    github = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    issues = github.list_issues(repo, state: 'open')
    issue_titles = issues.map(&:title)

    #get pending examples
    examples = config.instance_variable_get(:@reporter)
    pendings = examples.pending_examples

    pendings.each do |example|
      title = example.full_description
      body = "#{example.location}\n\nThis issue was created automatically by rspec-snitch."

      unless issue_titles.include? title
        github.create_issue(repo, title, body) if example.pending?
      end
    end
  end
end
