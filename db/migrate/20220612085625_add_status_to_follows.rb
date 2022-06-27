# frozen_string_literal: true

class AddStatusToFollows < ActiveRecord::Migration[5.2]
  def change
    add_column :follows, :status, :string, null: false, default: 'pending'
  end
end
