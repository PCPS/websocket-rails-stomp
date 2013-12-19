module WebsocketRails
  module Stomp
    module Error
      # InvalidFormat is raised if:
      # * During frame parsing if a malformed frame is detected.
      class InvalidFormat < RuntimeError
        def message
          "Invalid message - invalid format"
        end
      end

      # InvalidServerCommand is raised if:
      # * An invalid STOMP COMMAND is received from the server.
      class InvalidServerCommand < RuntimeError
        def message
          "Invalid command from server"
        end
      end

      # InvalidMessageLength is raised if:
      # * An invalid message length is detected during a frame read.
      class InvalidMessageLength < RuntimeError
        def message
          "Invalid content length received"
        end
      end
    end
  end
end
