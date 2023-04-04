# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :status
      t.uuid :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
