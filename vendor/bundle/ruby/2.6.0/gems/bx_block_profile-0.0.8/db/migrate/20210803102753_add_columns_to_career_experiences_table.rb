class AddColumnsToCareerExperiencesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :career_experiences, :current_salary, :decimal, default: 0.00
    add_column :career_experiences, :currently_working_at, :text
    add_column :career_experiences, :notice_period, :text
    add_column :career_experiences, :notice_period_end_date, :date
  end
end
