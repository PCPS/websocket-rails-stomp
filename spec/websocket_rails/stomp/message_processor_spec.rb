require "spec_helper"

module WebsocketRails
  module Stomp
    describe MessageProcessor do

      SUBSCRIBE_MESSAGE = ["SUBSCRIBE\n", "destination:/queue/foo\n", "\n", "body value\n", "\000\n"].join

      let(:connection) { double("Conection").as_null_object }
      let(:subscribe_message) { Frame.new(SUBSCRIBE_MESSAGE) }
      let(:message) { Stomp::Message.new(subscribe_message, connection) }

      before do
        message.stub(:connection).and_return connection
      end

      it "should include WebsocketRails::Processor" do
        subject.should be_a WebsocketRails::Processor
      end

      describe "#processes?" do
        it "returns true for stomp messages" do
          subject.processes?(message).should == true
        end
      end

      describe "#process_message" do
        it "processes inbound STOMP messages" do
          WebsocketRails['/queue/foo'].should_receive(:subscribe).with connection
          subject.process_message(message)
        end
      end

    end
  end
end
