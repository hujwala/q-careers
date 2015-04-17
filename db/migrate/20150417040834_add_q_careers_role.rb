class AddQCareersRole < ActiveRecord::Migration
  def change
    add_column  :users, :q_careers_role, :string, limit: 32, default: "employee"
    add_index   :users, :q_careers_role
  end
end
