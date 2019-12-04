class RemoveNomeFromClient < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :nome, :string
  end
end
