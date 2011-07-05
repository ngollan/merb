# encoding: UTF-8

module Merb
  module Generators
    class MerbFlat < AppGenerator

      source_paths << template_base('application/merb_flat')

      app_class_options

      def create_application
        copy_file 'README.txt'

        template 'application.rbt', 'application.rb'

        directory 'config'
        directory 'views'
        directory (testing_framework == :rspec ? "spec" : "test")
      end

    end
  end
end










