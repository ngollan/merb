# encoding: UTF-8

module Merb::Generators

  class Helper < NamespacedGenerator

    def self.source_root
      File.join(super, 'component', 'helper')
    end

    desc <<-DESC
      Generates a new helper.
    DESC

    class_option :testing_framework,
      :desc => 'Testing framework to use (one of: rspec, test_unit)'

    #FIXME: still Templater
    def create_helper
      template :helper do |template|
        template.source = 'app/helpers/%file_name%_helper.rb'
        template.destination = "app/helpers" / base_path / "#{file_name}_helper.rb"
      end
    end

  end

  #add :helper, HelperGenerator

end
