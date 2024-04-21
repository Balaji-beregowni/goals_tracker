class CreateOkrs < ActiveRecord::Migration[6.0]
  def change
    create_table :okrs do |t|
      t.text :description
      t.boolean :completion_status
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
