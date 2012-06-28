class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :event
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
