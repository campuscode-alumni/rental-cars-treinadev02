class CreateCarModels < ActiveRecord::Migration[5.2]
  def change
    create_table :car_models do |t|
      t.string :name
      t.string :motorization
      t.string :fuel_type
      t.integer :year
      t.references :car_category, foreign_key: true
      t.references :manufacturer, foreign_key: true

      t.timestamps
    end
  end
end
