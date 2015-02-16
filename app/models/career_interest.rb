class CareerInterest < ActiveRecord::Base

  # Associations
  belongs_to :candidate
  belongs_to :event

  # Validations
  validates :candidate, presence: true
  validates :event, presence: true

  # Class Methods

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> candidate_search.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(candidates.name) LIKE LOWER('%#{query}%') OR LOWER(candidates.skills) LIKE LOWER('%#{query}%') OR LOWER(candidates.current_city) LIKE LOWER('%#{query}%') OR LOWER(candidates.native_city) LIKE LOWER('%#{query}%')")}

  def self.fetch(event, candidate)
    CareerInterest.where("event_id = ? AND candidate_id = ?", event.id, candidate.id).first || CareerInterest.new(event: event, candidate: candidate)
  end

  # Instance Methods

  def application_id
    "EV#{event.id}-CI#{id}"
  end

  def confirm!
    update_attributes(confirmed: true, confirmed_at: Time.now)
  end

  def applicant_name
    candidate.name
  end

end
