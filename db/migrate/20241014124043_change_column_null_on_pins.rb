class ChangeColumnNullOnPins < ActiveRecord::Migration[6.1]
  def change
    change_column_null :pins, :name, true
    change_column_null :pins, :address, true
  end
end
