# encoding: UTF-8

#FIXME: mostly Templater
module Merb::Generators
  class Passenger < AppGenerator

    desc <<-DESC
      Generates the configuration files needed to run Merb with Phusion Passenger.
    DESC

    def self.source_root
      File.join(super, 'application', 'merb_stack')
    end

    def create_passenger
      file :config, "config.ru"
    end
  end

  # add :passenger, PassengerGenerator
end
