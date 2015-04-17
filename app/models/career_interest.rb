class CareerInterest < ActiveRecord::Base

  # Associations
  belongs_to :candidate
  belongs_to :event
  belongs_to :referrer

  # Validations
  validates :candidate, presence: true
  validates :event, presence: true

  # Callbacks
  before_save :check_source_and_referrer

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
    source_code = source.split("_").map{|x| x[0].capitalize}.join("")
    "#{event.id}-#{source_code}#{100+id}"
  end

  def confirm!
    update_attributes(confirmed: true, confirmed_at: Time.now)
  end

  def applicant_name
    candidate.name
  end

  def change_referrer(user)
    self.referrer = user
    self.save
  end

  private

  def check_source_and_referrer
    self.source = :employe_referral if referrer.present?
  end

end
