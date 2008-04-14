class AddEditorRole < ActiveRecord::Migration
  def self.up
    editor_role = Role.create(:name => 'Editor')
    admin_user = User.find_by_username('Admin')
    admin_user.roles << editor_role
  end

  def self.down
    editor_role = Role.find_by_name('Editor')
    admin_user = User.find_by_username('Admin')
    admin_user.roles.delete(editor_role)
    editor_role.destroy 
  end
end
