class CreateCatHobbies < ActiveRecord::Migration[5.0]
  def change
    create_table :cat_hobbies do |t|
      t.references :cat, foreign_key: true, index: true
      t.references :hobby, foreign_key: true, index: true

      t.timestamps
    end
  end
end
