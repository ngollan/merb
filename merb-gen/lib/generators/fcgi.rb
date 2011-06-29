# encoding: UTF-8

#FIXME: mostly Templater
module Merb::Generators
  class Fcgi < AppGenerator

    desc <<-DESC
      Generates the configuration files needed to run Merb with FastCGI.
    DESC

    def self.source_root
      File.join(super, 'component', 'fcgi')
    end

    def create_fcgi
      file :dothtaccess, "dothtaccess", File.join("public", ".htaccess")
      file :merbfcgi, "merb.fcgi", File.join("public", "merb.fcgi")
    end
  end

  #add :fcgi, FcgiGenerator
end
