class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user
      t.references :book

      t.string :ref
      t.string :snippet

      t.timestamps null: false
    end
  end
end
