require 'rails/generators'
require 'rails/generators/base'

module LolcationClient
  module Generators
    class MigrationGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def copy_migration
        generate_model_if_does_not_exists
        template "migration.rb", "db/migrate/#{Time.zone.now.strftime("%Y%m%d%H%M%S")}_add_lolcation_to_#{table_name}.rb"
      end

      private

      def model_exists?
        File.exist?(File.join(destination_root, model_path))
      end

      def migration_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_lolcalization_to_#{table_name}.rb$/).first
      end

      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

      def attributes_and_types
        attributes.map do |attribute|
          "#{attribute.name}:#{attribute.type}"
        end.join(' ')
      end

      def generate_model_if_does_not_exists
        unless model_exists?
          system "rails generate model #{name} #{attributes_and_types} --force"
          sleep 1
        end
      end
    end
  end
end
