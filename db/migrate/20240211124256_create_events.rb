class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.integer :owner

      t.timestamps
    end
  end
end
