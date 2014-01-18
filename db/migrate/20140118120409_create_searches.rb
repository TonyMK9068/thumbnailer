class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string   "keyword",    :null => false
      t.integer  "page", :default => 1
      t.timestamps
    end
  end
end
