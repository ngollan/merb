# encoding: UTF-8

module Merb::Generators
  class PartController < NamespacedGenerator

    source_root(template_base('component/part_controller'))

    desc 'Generate a new part controller.'

    def create_part_controller
      invoke Helper, ["#{full_class_name}Part"]

      directory 'app'
    end

  end
end
