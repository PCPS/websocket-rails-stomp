module WebsocketRails
  module Stomp
    # Client generated frames
    CMD_CONNECT     = "CONNECT"
    CMD_STOMP       = "STOMP"
    CMD_DISCONNECT  = "DISCONNECT"
    CMD_SEND        = "SEND"
    CMD_SUBSCRIBE   = "SUBSCRIBE"
    CMD_UNSUBSCRIBE = "UNSUBSCRIBE"
    CMD_ACK         = "ACK"
    CMD_NACK        = "NACK"
    CMD_BEGIN       = "BEGIN"
    CMD_COMMIT      = "COMMIT"
    CMD_ABORT       = "ABORT"

    # Server generated names
    CMD_CONNECTED = "CONNECTED"
    CMD_MESSAGE   = "MESSAGE"
    CMD_RECEIPT   = "RECEIPT"
    CMD_ERROR     = "ERROR"

    # Protocols
    SPL_10 = "1.0"
    SPL_11 = "1.1"
    SPL_12 = "1.2"

    # Stomp 1.0 and 1.1
    SUPPORTED = [SPL_10, SPL_11, SPL_12]

    # 1.9 Encoding Name
    UTF8 = "UTF-8"
    #
    # Octet 0
    #
    NULL = "\0"
    #
    # New line
    #
    NL = "\n"
    NL_ASCII = 0x0a
    #
    # Line Feed (New Line)
    #
    LF = "\n"
    LF_ASCII = 0x0a
    #
    # New line
    #
    CR = "\r"
    CR_ASCII = 0x0d
    #
    # Back Slash
    #
    BACK_SLASH = "\\"
    BACK_SLASH_ASCII = 0x5c
    #
    # Literal colon
    #
    LITERAL_COLON = ":"
    COLON_ASCII = 0x3a
    #
    # Literal letter c
    #
    LITERAL_C = "c"
    C_ASCII = 0x63
    #
    # Literal letter n
    #
    LITERAL_N = "n"
    N_ASCII = 0x6e
    #
    # Codec from/to values.
    #
    ENCODE_VALUES = [
      "\\\\\\\\", "\\", # encoded, decoded
      "\\" + "n", "\n",
      "\\" + "r", "\r",
      "\\c", ":",
    ]

    #
    DECODE_VALUES = [
      "\\\\", "\\", # encoded, decoded
      "\\" + "n", "\n",
      "\\" + "r", "\r",
      "\\c", ":",
    ]
  end
end
