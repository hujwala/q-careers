class AddReportedToCareerInterests < ActiveRecord::Migration
  def change
    add_column  :career_interests, :reported, :boolean, default: false
    add_column  :career_interests, :reported_at, :date
    add_column  :career_interests, :status, :string, limit: 28, default: :applied
  end
end
