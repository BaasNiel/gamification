class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :avatar
      t.string :start_of_week
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
