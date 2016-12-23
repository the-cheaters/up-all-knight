require 'pusher'

Pusher.app_id = ENV['pusher_app_id']
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']
Pusher.logger = Rails.logger
Pusher.encrypted = true
