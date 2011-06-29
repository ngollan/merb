require 'spec_helper'

describe Merb::Generators::MerbVeryFlat do

  describe "templates" do

    def app_path(*frags)
      File.join('/tmp', @app_name, *frags)
    end

    before :all do
      @app_name = "testing#{Process.pid}"
      @generator = Merb::Generators::MerbVeryFlat.new([@app_name], {}, {:destination_root => app_path})
    end

    after :all do
      raise "Not going to remove: #{app_path}" unless app_path.match?(/\A\/tmp\/testing\d+/)
      FileUtils.rm_r(app_path)
    end

    it_should_behave_like "named generator"
    it_should_behave_like "app generator"

    it "should write to the supplied application path" do
      @generator.destination_root.should == app_path
    end

    it "should create the application" do
      lambda do
        @generator.invoke_all
      end.should_not raise_error
    end

    describe "File creation" do
      [
        'Gemfile', 'bin/merb'
      ].each do |fname|
        it "should create #{fname}" do
          File.exist?(app_path(fname)).should be_true
        end
      end

      it "should create a number of views"

    end

  end

end
