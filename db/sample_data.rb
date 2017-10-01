# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require File.join([Rails.root, 'lib', 'random_string'])

['jon@bunnymatic.com'].each do |email|
  pass = RandomString.generate
  pass = 'monkey' if Rails.env != 'production'
  u = User.new
  u.email = email
  u.password = pass
  puts "Created #{email} #{pass}" if u.save
end
