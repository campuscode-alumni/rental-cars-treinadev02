class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :nome
      t.string :cpf
      t.string :email

      t.timestamps
    end
  end
end
