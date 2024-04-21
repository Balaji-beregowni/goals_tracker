class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.integer :completion_status, default: 0

      t.timestamps
    end
  end
end
