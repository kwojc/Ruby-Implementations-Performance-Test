class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :name
      t.string :engine
      t.string :version
      t.float :time

      t.timestamps null: false
    end
  end
end
