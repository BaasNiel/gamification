class CreateSprints < ActiveRecord::Migration[5.1]
  def change
    create_table :sprints do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :expected_score
      t.integer :actual_score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
