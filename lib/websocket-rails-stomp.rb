lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'websocket-rails'

['v10.stomp', 'v11.stomp', 'v12.stomp'].each do |protocol|
  WebsocketRails.supported_protocols << protocol
end

require 'websocket_rails/stomp/constants'
require 'websocket_rails/stomp/error'
require 'websocket_rails/stomp/frame'
require 'websocket_rails/stomp/message'
require 'websocket_rails/stomp/message_handler'
require 'websocket_rails/stomp/message_processor'
