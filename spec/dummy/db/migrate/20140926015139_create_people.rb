class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, :food, :color
      t.timestamps
    end
  end
end
