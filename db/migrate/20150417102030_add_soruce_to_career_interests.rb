class AddSoruceToCareerInterests < ActiveRecord::Migration
  def change
    add_reference :career_interests, :referrer, index: true
    add_column  :career_interests, :source, :string, limit: 128, default: :registration_desk, index: true
    CareerInterest.update_all(source: :candidate)
  end
end
