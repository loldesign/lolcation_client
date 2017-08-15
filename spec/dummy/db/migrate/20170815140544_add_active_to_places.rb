class AddActiveToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :active, :boolean, default: false
  end
end
