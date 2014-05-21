class ConvertCommentToPolymorphic < ActiveRecord::Migration
  def change
    remove_index :comments, :answer_id
    rename_column :comments, :answer_id, :commentable_id
    add_index :comments, :commentable_id

    add_column :comments, :commentable_type, :string
    add_index :comments, :commentable_type
  end
end
