class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :task
      t.boolean :completed

      t.timestamps
    end
  end
end
