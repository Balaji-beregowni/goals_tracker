class AddDefaultFalseToOkrsCompletionStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :okrs, :completion_status, :boolean, default: false
  end
end
