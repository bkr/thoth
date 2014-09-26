class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, :breed
      t.timestamps
    end
  end
end
