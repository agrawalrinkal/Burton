class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.belongs_to :user

      t.references :reading_group

      t.string :uuid
      t.string :title
      t.string :authors
      t.text :description
      t.string :format
      t.string :url
      t.string :cover

      t.attachment :epub

      t.timestamps null: false
    end
  end
end
