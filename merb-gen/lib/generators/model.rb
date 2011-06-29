# encoding: UTF-8

module Merb::Generators
  class Model < NamespacedGenerator

    include AppGeneratorHelpers

    source_root(template_base('component/model'))

    desc <<-DESC
      Generates a new model. You can specify an ORM different from what the rest
      of the application uses.
    DESC

    class_option_for :testing_framework
    class_option_for :orm

    argument :attributes,
      :type => :hash,
      :default => {},
      :desc => "space separated model properties in form of name:type. Example: state:string"

    def create_model
      directory 'app'
      directory (testing_framework == :rspec ? "spec" : "test")
    end

    protected

    def attributes?
      self.attributes && !self.attributes.empty?
    end

    def attributes_for_accessor
      self.attributes.keys.map{|a| ":#{a}" }.compact.uniq.join(", ")
    end

  end
end
