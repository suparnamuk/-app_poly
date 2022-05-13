class AddBankToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :bank_name, :string

    add_column :accounts, :account_number, :integer

    add_column :accounts, :ifsc_code, :string
  end
end