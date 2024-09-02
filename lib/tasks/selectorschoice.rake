# frozen_string_literal: true

require 'uri'
require_relative '../s3'

namespace :sc do
  namespace :db do
    desc 'Sanitize user data'
    task sanitize_user_data: [:environment] do
      User.find_each do |u|
        u.password = 'monkey'
        u.save
      end
    end
  end
end
