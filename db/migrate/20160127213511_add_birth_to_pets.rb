class AddBirthToPets < ActiveRecord::Migration
  def change
    add_column :pets, :birth, :date
  end
end
