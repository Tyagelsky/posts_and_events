class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
