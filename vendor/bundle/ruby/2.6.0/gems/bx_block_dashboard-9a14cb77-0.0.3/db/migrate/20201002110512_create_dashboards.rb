class CreateDashboards < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboards do |t|
      t.string :title
      t.integer :value

      t.timestamps
    end
  end
end
