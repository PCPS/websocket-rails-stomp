module WebsocketRails
  module Stomp

    class Message < WebsocketRails::Message

      def self.new_invalid_message(raw_message, connection)
        frame = Frame.new(nil)
        frame.original = raw_message

        message = Message.new(frame, connection)
        message.command = :ERROR
        message.headers[:message] = "malformed message received"
        message
      end

      def self.connected(connect_message, connection)
        message = Stomp::Message.new(nil, connection)
        message.command = :CONNECTED
        message.headers[:version] = "1.2"
        message.headers[:host] = WebsocketRails.config.hostname
        message
      end

      def self.send_message(send_message, connection)
        message = Stomp::Message.new(nil, connection)
        message.command = :SEND
        message.headers = send_message.headers.dup
        message.body = send_message.body.dup
        message
      end

      def self.receipt(message, connection)
        message.command = :RECEIPT
        message_id = message.headers.delete('message-id')
        message.headers.clear
        message.headers['receipt-id'] = message_id
        message.body = nil
        message
      end

      def self.deserialize(raw_message, connection)
        frame = Frame.new(raw_message)
        new frame, connection
      rescue Error::InvalidFormat => ex
        warn "Invalid STOMP message received: #{ex.message}"
        warn "Invalid message: \n#{raw_message}"
        new_invalid_message raw_message, connection
      rescue StandardError => ex
        warn "Invalid STOMP command received: #{ex.message}"
        warn "Invalid message: \n#{raw_message}"
        new_invalid_message raw_message, connection
      end

      attr_reader :frame, :connection

      def initialize(frame, connection)
        @frame = frame || Frame.new(nil, true)
        @connection = connection
      end

      def type
        :stomp
      end

      def command
        @frame.command.to_s.to_sym
      end

      def command=(new_command)
        @frame.command = new_command.to_s
      end

      def headers
        @frame.headers
      end

      def headers=(new_headers)
        @frame.headers = new_headers
      end

      def body
        @frame.body
      end

      def body=(new_body)
        @frame.body = new_body
      end

      def serialize
        self.body = '' if self.body == nil
        result = command.to_s + "\n"

        body_length_bytes = body.respond_to?(:bytesize) ? body.bytesize : body.length
        headers['content-length'] = "#{body_length_bytes}" unless headers[:suppress_content_length]

        headers['content-type'] = "text/plain; charset=UTF-8" unless headers['content-type']

        self.headers.each_pair do |key, value|
          result << "#{key.to_s}:#{value}\n"
        end

        result << "\n"
        result << body.to_s
        result << "\000\n"
        result
      end

      private

      def append_cr(data)
        "#{data}#{Stomp::CR}"
      end

      def append_crlf(data)
        "#{data}#{Stomp::CR}#{Stomp::LF}"
      end

    end

  end
end
