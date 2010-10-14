class CreateHangingChadTables < ActiveRecord::Migration
  def self.up
    create_table "votes" do |t|
      t.integer :votable_id
      t.string :votable_type
      t.string :kind

      t.integer :user_id
      t.boolean :value


      t.timestamps
    end

    add_index :votes, [:votable_type, :votable_id]
    add_index :votes, :kind
    add_index :votes, :user_id

    create_table :vote_totals do |t|
      t.integer :votable_id
      t.string :votable_type
      t.string :kind
      
      t.integer :total
      t.integer :ayes
      t.integer :nays

      t.float :percent_ayes


      t.timestamps
    end

    add_index :vote_totals, [:votable_type, :votable_id]
    add_index :vote_totals, :kind
  end

  def self.down
    drop_table "votes"
    drop_table "vote_totals"
  end
end
