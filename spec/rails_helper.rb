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

  config.after(:suite) do
    #get github issues
    github = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    issues = github.list_issues('freddyrangel/snitch-example')
    issue_titles = issues.map(&:title)
    puts issue_titles
  end
end
