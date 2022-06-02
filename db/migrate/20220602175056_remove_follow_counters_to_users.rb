class RemoveFollowCountersToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :followers_count
    remove_column :users, :followings_count
  end
end
