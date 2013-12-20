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
          if message.headers["receipt-id"]
            send_receipt message
          end
        when :UNSUBSCRIBE
          channel_manager[message.headers['destination']].unsubscribe message.connection
          if message.headers["receipt-id"]
            send_receipt message
          end
        when :SEND
          send_message = Message.send(message, connection)
          channel_manager[message.headers['destination']].trigger_event send_message
          if message.headers["receipt-id"]
            send_receipt message
          end
        when :DISCONNECT
          if message.headers["receipt-id"]
            send_receipt message
          end
          message.connection.close_connection
        end
      end

      private

      def send_receipt(message)
        receipt = Stomp::Message.receipt(message, message.connection)
        message.connection.trigger receipt
      end

    end
  end
end
