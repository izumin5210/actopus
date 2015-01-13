class RemoveColumnsForConfirmableFromStaffs < ActiveRecord::Migration
  def change
    remove_column :staffs, :confirmation_token, :string
    remove_column :staffs, :confirmed_at, :datetime
    remove_column :staffs, :confirmation_sent_at, :datetime
    remove_column :staffs, :unconfirmed_email, :string
  end
end
