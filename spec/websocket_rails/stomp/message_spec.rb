require "spec_helper"

module WebsocketRails
  module Stomp
    describe Message do

      CONNECT_MESSAGE = ["CONNECT\n", "session:host_address\n", "\n", "body value\n", "\000\n"].join
      SUBSCRIBE_MESSAGE = ["SUBSCRIBE\n", "destination:/queue/foo\n", "\n", "body value\n", "\000\n"].join

      SERIALIZED_SUBSCRIBE_MESSAGE = "SUBSCRIBE\r\ndestination:/queue/foo\r\ncontent-length:11\r\ncontent-type:text/plain; charset=UTF-8\r\n\r\nbody value\n\u0000\r\n"

      let(:connection) { double("Conection") }
      let(:subscribe_message) { Frame.new(SUBSCRIBE_MESSAGE) }
      subject { Message.deserialize(SUBSCRIBE_MESSAGE, connection) }

      describe ".send_message" do
        it "creates a valid SEND message" do
          original = double(Message)
          original.stub(:headers).and_return(destination: 'queue')
          original.stub(:body).and_return "body"
          message = Message.send_message(original, connection)
          message.body.should == original.body
          message.headers[:destination].should == 'queue'
        end
      end

      describe ".deserialize" do
        it "deserializes a valid stomp message" do
          Message.deserialize(SUBSCRIBE_MESSAGE, connection).frame.to_s.should == subscribe_message.to_s
        end
      end

      describe "#type" do
        it "returns :stomp" do
          subject.type.should == :stomp
        end
      end

      describe "#command" do
        it "delegates to the STOMP frame and symbolizes the command" do
          subject.command.should == :SUBSCRIBE # subscribe_message.command.to_sym
        end
      end

      describe "#headers" do
        it "delegates to the STOMP frame" do
          subject.headers.should == subscribe_message.headers
        end
      end

      describe "#body" do
        it "delegates to the STOMP frame" do
          subject.body.should == "body value\n" # subscribe_message.body
        end
      end

      describe "#serialize" do
        it "creates a serialized stomp frame" do
          subject.serialize.should == "SUBSCRIBE\ndestination:/queue/foo\ncontent-length:11\ncontent-type:text/plain; charset=UTF-8\n\nbody value\n\x00\n"
        end
      end

    end
  end
end
