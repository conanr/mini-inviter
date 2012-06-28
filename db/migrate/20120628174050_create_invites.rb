class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :event
      t.belongs_to :contact

      t.timestamps
    end
  end
end
