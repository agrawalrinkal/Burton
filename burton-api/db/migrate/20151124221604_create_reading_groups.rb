class CreateReadingGroups < ActiveRecord::Migration
  def change
    create_table :reading_groups do |t|
      t.belongs_to :user

      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
