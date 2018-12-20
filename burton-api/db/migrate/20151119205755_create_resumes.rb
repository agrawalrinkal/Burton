class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.belongs_to :user
      t.references :book

      t.integer :spine_position
      t.text    :styles

      t.timestamps null: false
    end
  end
end
