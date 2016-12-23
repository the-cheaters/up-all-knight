require 'pusher'

Pusher.app_id = ENV['pusher_app_id']
Pusher.key = '69d78adae1cff6a25019'
Pusher.secret = '2e93a2f25562af81490e'
Pusher.logger = Rails.logger
Pusher.encrypted = true
