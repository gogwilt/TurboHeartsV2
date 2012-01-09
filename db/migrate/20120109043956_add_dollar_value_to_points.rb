class AddDollarValueToPoints < ActiveRecord::Migration
  def change
    add_column :points, :dollar_value, :integer
  end
end
