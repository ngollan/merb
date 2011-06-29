# encoding: UTF-8

require 'merb-gen/helpers/generator_helpers'

module Merb
  module Generators

    class AppGenerator < NamedGenerator
      include AppGeneratorHelpers

      source_paths << template_base('application/common')

      def initialize(*args)
        Merb.disable(:initfile)

        super
      end

      def create_application_base
        directory 'bin'

        template 'Rakefile'
        template 'Gemfile'

        copy_file 'dotgitignore', '.gitignore'
        copy_file 'dotrspec', '.rspec'
      end
    end

  end
end
