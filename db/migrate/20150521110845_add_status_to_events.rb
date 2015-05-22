class AddStatusToEvents < ActiveRecord::Migration
  def change
  	add_column  :events, :status, :string, default: 'planning', limit: 28
    add_index   :events, :status
    event = Event.find_by_slug("qwinix-careers")
    event.update_attribute(:status, :scheduled) if event
  end
end
