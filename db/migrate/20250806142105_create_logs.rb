class CreateLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :logs do |t|
      t.string :level
      t.text :message
      t.datetime :timestamp
      t.string :source
      t.jsonb :raw_log

      t.timestamps
    end
  end
end
