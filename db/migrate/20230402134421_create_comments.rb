# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.text :content
      t.uuid :user_id, null: false, foreign_key: true
      t.uuid :project_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
