# encoding: UTF-8

#FIXME: mostly Templater
module Merb::Generators

  class Model < NamespacedGenerator

    def self.source_root
      File.join(super, 'component', 'model')
    end

    desc <<-DESC
      Generates a new model. You can specify an ORM different from what the rest
      of the application uses.
    DESC

    class_option :testing_framework,
      :desc => 'Testing framework to use (one of: rspec, test_unit)'

    class_option :orm,
      :desc => 'Object-Relation Mapper to use (one of: none, activerecord, datamapper, sequel)'

    argument :attributes,
      :type => :hash,
      :default => {},
      :desc => "space separated model properties in form of name:type. Example: state:string"

    def create_model
      template :model_none, :orm => :none do |template|
        template.source = "app/models/%file_name%.rb"
        template.destination = "app/models" / base_path / "#{file_name}.rb"
      end

      template :spec, :testing_framework => :rspec do |template|
        template.source = 'spec/models/%file_name%_spec.rb'
        template.destination = "spec/models" / base_path / "#{file_name}_spec.rb"
      end

      template :test_unit, :testing_framework => :test_unit do |template|
        template.source = 'test/models/%file_name%_test.rb'
        template.destination = "test/models" / base_path / "#{file_name}_test.rb"
      end
    end

    def attributes?
      self.attributes && !self.attributes.empty?
    end

    def attributes_for_accessor
      self.attributes.keys.map{|a| ":#{a}" }.compact.uniq.join(", ")
    end

    def after_generation
      STDOUT.puts "\n\nDon't forget to add model tests first."
    end
  end

  # add :model, ModelGenerator
end
