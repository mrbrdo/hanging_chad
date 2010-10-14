class HangingChadGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  
  include Rails::Generators::Migration
  
  def copy_files
    copy_file   'vote.rb'      , 'app/models/vote.rb'
    copy_file   'vote_total.rb', 'app/models/vote_total.rb'
    migration_template 'create_hanging_chad_tables.rb', "db/migrate/create_hanging_chad_tables.rb"
  end
  
private
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
end
