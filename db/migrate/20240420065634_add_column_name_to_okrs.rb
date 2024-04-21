class AddColumnNameToOkrs < ActiveRecord::Migration[6.0]
  def change
    add_column :okrs, :name, :string
  end
end
