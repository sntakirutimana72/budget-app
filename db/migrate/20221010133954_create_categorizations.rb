class CreateCategorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :categorizations, id: false do |t|
      t.references :category, null: false, foreign_key: true
      t.references :entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
