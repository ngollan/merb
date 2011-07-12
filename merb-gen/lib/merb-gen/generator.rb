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

    # Get a list of registered generators.
    #
    # @api plugin
    def self.generators(namespace = '')
      if namespace.empty?
        Generator.generators
      else
        key_regex = /\A#{Regexp.escape(namespace)}:.+/.freeze
        Generator.generators.reject {|k, _| k.match(key_regex).nil? }
      end
    end

    # Base class for generators producing applications or components.
    class Generator < Thor::Group
      include Merb::ColorfulMessages
      include Merb::Generators::GeneratorHelpers
      include Thor::Actions

      desc "Generate components for your application or entirely new applications."

      class << self
        # Template base path.
        #
        # @param [String*] frags A number of path fragments that will be
        #   appended to the template path.
        #
        # @return [String] An absolute path to the template direcory, or a
        #   subdirectory thereof.
        #
        # @api plugin
        def template_base(*frags)
          tb = File.join(File.expand_path('../../generators/templates', __FILE__))

          if frags.empty?
            tb
          else
            File.join(tb, *frags)
          end
        end

        # @api private
        def generators
          @@generators ||= {}
        end

        def _itself
          self
        end

        # Register a generator for public use.
        #
        # @note We use Thor-like namespacing, with ':' as the path separator.
        #   You should not use that character in the namespace or the name,
        #   but if you do so, it will _not_ be filtered.
        #
        # @param [#to_s] namespace The namespace under which the generator
        #   is to be registered. This is deduced from the full class name,
        #   using all modules under Merb::Generators as components.
        # @param [#to_s] name The generator name. If none is given, a name
        #   is generated froom the class name.
        #
        # @example
        #    module Merb::Generators
        #      module Mailer
        #        class DogFood < Generator
        #          register      # registers 'mailer:dog_food'
        #        end
        #      end
        #    end
        #
        # @api plugin
        def register(namespace = nil, name = nil)
          register_path = _itself.to_s.split('::')[2..-1].map(&:underscore)

          if namespace.nil?
            if register_path.size > 1
              namespace = register_path[0...-1].join(':')
            else
              namespace = 'merb'
            end
          end

          register_name = name || register_path.last
          register_name = "#{namespace.to_s.strip}:#{register_name.to_s.strip}"

          raise "Generator #{register_name} already exists (class: #{self.generators[register_name]})" if self.generators.has_key?(register_name)

          self.generators[register_name] = _itself
        end
      end

      # @overload initialize(args=[], options={}, config={})
      #   Normal Thor generator calling convention.
      #
      #   @option config [Boolean] :no_merb_load Set to `true` to avoid
      #     loading a Merb application in the current working directory.
      def initialize(*args)
        _args, _options, _config = args

        unless _config.delete(:no_merb_load)
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

          _options.merge({:orm => Merb.orm}) if Merb.orm
          _options.merge({:template_engine => Merb.template_engine}) if Merb.template_engine
          _options.merge({:testing_framework => Merb.test_framework}) if Merb.test_framework
        end

        super(_args, _options, _config)
      end

    end

  end

end
