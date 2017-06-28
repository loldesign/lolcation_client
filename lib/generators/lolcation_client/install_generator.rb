require 'rails/generators'
require 'rails/generators/base'

module LolcationClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_yml_file
        template "lolcation.yml", "config/lolcation.yml"

        puts "Do not forget to change your token at config/lolcation.yml"
      end
    end
  end
end
