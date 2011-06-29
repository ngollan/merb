# encoding: UTF-8

#FIXME: mostly Templater
module Merb::Generators

  class ResourceGenerator < Generator

    desc <<-DESC
      Generates a new resource.
    DESC

    argument :name,
      :required => true,
      :desc => "resource name (singular)"

    argument :attributes,
      :type => :hash,
      :default => {},
      :desc => "space separated resource model properties in form of name:type. Example: state:string"

    class_option :testing_framework,
      :desc => 'Testing framework to use (one of: rspec, test_unit)'

    class_option :orm,
      :desc => 'Object-Relation Mapper to use (one of: none, activerecord, datamapper, sequel)'

    def create_resource
      invoke :model do |generator|
        generator.new(destination_root, options, model_name, attributes)
      end

      invoke :resource_controller do |generator|
        generator.new(destination_root, options, controller_name, attributes)
      end
    end

    def controller_name
      name.pluralize
    end

    def model_name
      name
    end

    def after_generation
      STDOUT << message("resources :#{model_name.pluralize.underscore} route added to config/router.rb")
    end
  end

  # add :resource, ResourceGenerator
end
