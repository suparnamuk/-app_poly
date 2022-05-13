class AddOccupationToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :occupation, :string

    add_column :accounts, :address, :string

    add_column :accounts, :pincode, :integer

    add_column :accounts, :exsisting_disease, :string
  end
end
