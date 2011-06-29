# encoding: UTF-8

require 'merb-gen/helpers/generator_helpers'

module Merb

  module ColorfulMessages
    # red
    def error(*messages)
      puts messages.map { |msg| "\033[1;31m#{msg}\033[0m" }
    end
    # yellow
    def warning(*messages)
      puts messages.map { |msg| "\033[1;33m#{msg}\033[0m" }
    end
    # green
    def success(*messages)
      puts messages.map { |msg| "\033[1;32m#{msg}\033[0m" }
    end

    alias_method :message, :success
  end

  module Generators
    class Generator < Thor::Group
      include Merb::ColorfulMessages
      include Merb::Generators::GeneratorHelpers
      include Thor::Actions

      desc "Generate components for your application or entirely new applications."

      # Template base path
      def self.template_base(frag=nil)
        tb = File.join(File.expand_path('../../generators/templates', __FILE__))

        if frag.nil?
          tb
        else
          File.join(tb, frag)
        end
      end

      def initialize(*args)
        Merb::Config.setup({
          :log_level        => :fatal,
          :log_delimiter    => " ~ ",
          :log_auto_flush   => false,
          :reload_templates => false,
          :reload_classes   => false
        })

        Merb::BootLoader::Logger.run
        Merb::BootLoader::BuildFramework.run
        Merb::BootLoader::Dependencies.run

        _args, _options, _config = args

        _options.merge({:orm => Merb.orm}) if Merb.orm
        _options.merge({:template_engine => Merb.template_engine}) if Merb.template_engine
        _options.merge({:testing_framework => Merb.test_framework}) if Merb.test_framework

        super(_args, _options, _config)
      end

    end

  end

end
