class CurrentAnnualSalaryCurrentStatus < ActiveRecord::Migration[6.0]
  def change
    create_table :current_annual_salary_current_status do |t|
      t.integer :current_status_id
      t.integer :current_annual_salary_id
      t.timestamps
    end
  end
end
