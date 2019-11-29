class RemoveOtherFromManufacturer < ActiveRecord::Migration[5.2]
  def change
    remove_column :manufacturers, :other, :string
  end
end
