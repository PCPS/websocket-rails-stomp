module WebsocketRails
  module Stomp
    class MessageProcessor

      include WebsocketRails::Processor

      def processes?(message)
        message.type == :stomp
      end

      def process_message(message)
        case message.command
        when :SUBSCRIBE
          channel_manager[message.headers['destination']].subscribe message.connection
          subscription = Stomp::Message.receipt(message, connection)
          message.connection.trigger subscription
        end
      end

    end
  end
end
