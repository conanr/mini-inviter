class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :user
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
