# frozen_string_literal: true

class AddAccountTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_type, :string, null: false, default: 'private'
  end
end
