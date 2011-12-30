class AddValueToPoints < ActiveRecord::Migration
  def change
    add_column :points, :value, :integer
  end
end
