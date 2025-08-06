class AddRayIdToLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :logs, :ray_id, :string
    add_index :logs, :ray_id
  end
end
