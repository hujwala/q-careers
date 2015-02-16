class AddSlugToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :slug, :string, limit: 256
    add_index   :events, :slug, :unique => true
  end
end
