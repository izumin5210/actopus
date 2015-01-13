class AddInvitableToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :invitation_token, :string
    add_column :staffs, :invitation_created_at, :datetime
    add_column :staffs, :invitation_sent_at, :datetime
    add_column :staffs, :invitation_accepted_at, :datetime
    add_column :staffs, :invitation_limit, :integer
    add_column :staffs, :invited_by_id, :integer
    add_column :staffs, :invited_by_type, :string
    add_index :staffs, :invitation_token, unique: true
    change_column :staffs, :encrypted_password, :string, null: true
  end
end
