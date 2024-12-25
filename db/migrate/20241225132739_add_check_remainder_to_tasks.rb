class AddCheckRemainderToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :check_remainder, :boolean
  end
end
