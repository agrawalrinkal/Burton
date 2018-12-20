class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|

      t.belongs_to :reading_group
      t.references :user
      t.references :role

      t.timestamps null: false
    end
  end
end
