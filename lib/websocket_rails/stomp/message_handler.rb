module WebsocketRails
  module Stomp
    class MessageHandler < WebsocketRails::AbstractMessageHandler

      def self.accepts?(protocol)
        protocol =~ /stomp/
      end

      def on_open(raw_message = nil)
        raw_message = raw_message.respond_to?(:data) ? raw_message.data : raw_message

        message = Stomp::Message.deserialize(raw_message, connection)

        process_command message
      end

      def on_message(raw_message = nil)
        message = Stomp::Message.deserialize(raw_message, connection)
        process_command message
      end

      def on_close(raw_message = nil)
        message = Stomp::Message.deserialize(raw_message, connection)
        process_command message
      end

      def on_error(raw_message = nil)
        message = Stomp::Message.deserialize(raw_message, connection)
        process_command message
      end

      # If we can quickly respond to the command do so here, otherwise
      # pass the message through to the Dispatcher system.
      def process_command(message)
        puts "processing message"
        puts message.frame
        case message.command
        when :CONNECT
          # Need to check the version here and send an ERROR
          # command if it's a version we do not support.
          if versions = message.headers['accept-version'].to_s.split(',')
            versions.include?('1.2')
            puts "accept version is: #{versions}"
            # handle version checking here
          end

          trigger Stomp::Message.connected(connection)
        else
          dispatch message
        end
      end

      private

      def dispatch(message)
        dispatcher.dispatch message
      end

      def trigger(message)
        connection.trigger message
      end

      def dispatcher
        connection.dispatcher
      end

    end
  end
end
