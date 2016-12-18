require 'pusher'

Pusher.app_id = '281181'
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']
Pusher.logger = Rails.logger
Pusher.encrypted = true
