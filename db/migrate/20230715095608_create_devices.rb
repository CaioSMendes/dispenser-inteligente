class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :device
      t.string :status
      t.string :ipadrrs
      t.integer :cont
      t.datetime :last_seen

      t.timestamps
    end
  end
end
