require 'rails/generators'
require 'rails/generators/base'

module LolcationClient
  module Generators
    class MigrationGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def copy_migration
        template "migration.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_add_lolcation_to_#{table_name}.rb"
      end
    end
  end
end
