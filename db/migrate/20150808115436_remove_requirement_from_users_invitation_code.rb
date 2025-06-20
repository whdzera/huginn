class RemoveRequirementFromUsersInvitationCode < ActiveRecord::Migration[4.2]
  def change
    default_value = ENV['INVITATION_CODE'].presence || 'try-huginn'
    change_column_null :users, :invitation_code, true, default_value
  end
end
