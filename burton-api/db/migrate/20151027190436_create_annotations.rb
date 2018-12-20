class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.belongs_to :user
      t.references :book

      t.string :base_uri
      t.text :quote
      t.text :ranges
      t.string :text

      t.timestamps null: false
    end
  end
end
