class AddStartTimeAndMapLinkToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :start_time, :string
    add_column  :events, :end_time, :string
    add_column  :events, :map_link, :string
    add_column  :events, :contact_person, :string
    add_column  :events, :contact_number, :string
  end
end
