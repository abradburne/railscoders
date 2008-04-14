class AddModeratorRole < ActiveRecord::Migration
  def self.up
    moderator_role = Role.create(:name => 'Moderator')
    admin_user = User.find_by_username('Admin')
    admin_user.roles << moderator_role
  end

  def self.down
    moderator_role = Role.find_by_name('Moderator')
    admin_user = User.find_by_username('Admin')
    admin_user.roles.delete(moderator_role)
    moderator_role.destroy
  end
end
