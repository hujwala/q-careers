class ChangeDateToDatetimeCareerInterests < ActiveRecord::Migration
  def change
    change_column :career_interests, :confirmed_at, :datetime
    change_column :career_interests, :reported_at, :datetime
  end
end
