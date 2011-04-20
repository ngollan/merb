require 'spec_helper'

describe MerbExceptions::DefaultExceptionExtensions do

  before(:each) do
    Merb::Router.prepare do
      default_routes
    end
  end

  it "should notify_of_exceptions" do
    MerbExceptions::Notification.should_receive(:new)
    with_level(:fatal) do
      visit("/not_found/index")
    end
  end

  it "should log fatal on failure" do
    MerbExceptions::Notification.should_receive(:new).and_raise(StandardError)
    with_level(:fatal) do
      visit("/not_found/index")
    end.should include_log("Exception Notification Failed:")
  end

end
