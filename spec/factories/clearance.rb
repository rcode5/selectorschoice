# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { |n| "user#{n}@example.com" }
    password { 'password' }
  end
end
