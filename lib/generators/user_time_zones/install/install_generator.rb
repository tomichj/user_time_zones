require 'rails/generators/base'
require 'rails/generators/active_record'
require 'generators/user_time_zones/helpers'

module UserTimeZones
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      include UserTimeZone::Generators::Helpers

      source_root File.expand_path('../templates', __FILE__)

      class_option :model,
                   optional: true,
                   type: :string,
                   banner: 'model',
                   desc: "Specify the model class name if you will use anything other than 'User'"

      class_option :javascript,
                   type: :boolean,
                   aliases: '-j',
                   default: false,
                   desc: 'Install javascript "require" into application.js'

      def initialize(*)
        super
        assign_names!(model_class_name)
      end

      def verify
        if options[:model] && !File.exist?(model_path)
          puts "Exiting: the model class you specified, #{options[:model]}, is not found."
          exit 1
        end
      end

      def copy_migration_files
        copy_migration 'add_time_zone_to_users.rb'
      end

      def inject_into_user_model
        if File.exist? model_path
          inject_into_class(model_path, model_class_name, "  include UserTimeZones::User\n\n")
        end
      end

      def inject_into_application_controller
        inject_into_class(
          'app/controllers/application_controller.rb',
          ApplicationController,
          "  include UserTimeZones::Controller\n\n"
        )
      end

      def inject_javascript
        javascript = File.join('app', 'assets', 'javascripts', 'application.js')
        if options.javascript && File.exist?(javascript)
          append_to_file 'app/assets/javascripts/application.js', '//= require user_time_zones'
        end
      end

      private

      def copy_migration(migration_name, config = {})
        # puts "migration_version: #{migration_version}"
        unless migration_exists?(migration_name)
          migration_template(
            "db/migrate/#{migration_name}",
            "db/migrate/#{migration_name}",
            config.merge(migration_version: migration_version)
          )
        end
      end

      # If Rails 5, then include the migration version. Rails 4, no version.
      def migration_version
        if Rails.version >= '5.0.0'
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end

      # for generating a timestamp when using `create_migration`
      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      def migration_exists?(name)
        existing_migrations.include?(name)
      end

      def existing_migrations
        @existing_migrations ||= Dir.glob('db/migrate/*.rb').map do |file|
          migration_name_without_timestamp(file)
        end
      end

      def migration_name_without_timestamp(file)
        file.sub(%r{^.*(db/migrate/)(?:\d+_)?}, '')
      end


    end
  end
end
