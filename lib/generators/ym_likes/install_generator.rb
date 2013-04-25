module YmLikes
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include YmCore::Generators::Migration
      include YmCore::Generators::Ability

      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmLikes."

      def manifest
        copy_file "models/like.rb", "app/models/like.rb"
        copy_file "controllers/likes_controller.rb", "app/controllers/likes_controller.rb"
        try_migration_template "migrations/create_likes.rb", "db/migrate/create_likes"
        
        if should_add_abilities?('Like')
          add_ability(:user, "can :manage, Like, :user_id => user.id")
        end
      end

    end
  end
end