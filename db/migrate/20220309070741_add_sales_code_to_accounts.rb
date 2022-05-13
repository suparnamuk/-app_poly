class AddSalesCodeToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :sales_code, :integer
  end
end
