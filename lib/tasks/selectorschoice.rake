# frozen_string_literal: true

require 'uri'
require_relative '../s3'

namespace :sc do
  namespace :s3 do
    desc 'Migrate from s3 url to filename'
    task migrate_from_s3_url: [:environment] do
      Track.all.each do |track|
        track.filename = track.url.sub(%r{^https?://.*amazonaws.com/#{SelectorsChoice::S3::BUCKET_NAME}/}, '')
        track.filename = track.filename.sub(%r{^https?://#{SelectorsChoice::S3::BUCKET_NAME}.*amazonaws.com/}, '')

        track.filename = CGI.unescape(track.filename)
        track.save!
      end
    end
  end

  namespace :db do
    desc 'Fetch the latest backup from heroku'
    task fetch: [:environment] do
      app = ENV['app']
      if app.blank?
        puts 'You must specify the heroku app name to get its database (use app=<appname>)'
      else
        url = `heroku pgbackups:url --app #{app}`
        db_prefix = app.tr('-', '_')
        fname = "#{db_prefix}_#{Time.zone.now.strftime('%Y%m%d')}.postgres"
        puts "Fetching database from #{url} - dumping to file #{fname}"
        `curl -o #{fname} \"#{url}\"`
      end
    end

    desc 'Import a dbfile into the development database on the local system'
    task import: [:environment] do
      dbfile = ENV['dbfile']
      if dbfile.blank? || !File.exist?(dbfile)
        puts 'You need to specify the database file to import with dbfile=<filename>'
      else
        `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d selectors_choice_dev #{dbfile}`
      end
    end

    desc 'Sanitize user data'
    task sanitize_user_data: [:environment] do
      User.all.each do |u|
        u.password = 'monkey'
        u.save
      end
    end
  end
end
