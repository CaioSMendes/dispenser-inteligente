class CreateSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
      t.string :status
      t.string :nome
      t.string :cardRFID
      t.string :cargo
      t.integer :contador

      t.timestamps
    end
  end
end
