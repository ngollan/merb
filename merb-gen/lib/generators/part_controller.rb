# encoding: UTF-8

module Merb::Generators

  class PartController < NamespacedGenerator

    def self.source_root
      File.join(super, 'component', 'part_controller')
    end

    desc <<-DESC
      Generates a new part controller.
    DESC

    #FIXME: still Templater
    def create_part_controller
      invoke :helper do |generator|
        generator.new(destination_root, options, "#{full_class_name}Part")
      end

      template :controller do |template|
        template.source = 'app/parts/%file_name%_part.rb'
        template.destination = "app/parts" / base_path / "#{file_name}_part.rb"
      end

      template :index do |template|
        template.source = 'app/parts/views/%file_name%_part/index.html.erb'
        template.destination = "app/parts/views" / base_path / "#{file_name}_part/index.html.erb"
      end
    end

  end

  #add :part, PartControllerGenerator

end
