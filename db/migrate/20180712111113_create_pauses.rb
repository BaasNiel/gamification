class CreatePauses < ActiveRecord::Migration[5.1]
  def change
    create_table :pauses do |t|
      t.references :pomodoro, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
