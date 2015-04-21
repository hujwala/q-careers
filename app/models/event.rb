class Event < ActiveRecord::Base

  # Associations
  has_many :career_interests
  has_many :candidates, through: :career_interests

  # Validations
  extend PoodleValidators

  validate_string :name, mandatory: true, format: /.*/i
  validate_string :slug, mandatory: true, format: /.*/i
  validates :date, presence: true
  validate_string :venue, mandatory: true, format: /\A[a-zA-Z1-9\,\.\-\ \(\)\.+]*\z/i
  validate_string :description, max_length: 2056, format: /.*/i

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> event.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(events.name) LIKE LOWER('%#{query}%') OR LOWER(events.venue) LIKE LOWER('%#{query}%') OR LOWER(events.description) LIKE LOWER('%#{query}%')")}

  # ----------------
  # Class Methods
  # ----------------

  def self.upcoming_events
    Event.where("slug != ?", 'qwinix-careers').where("date >= ?", Date.today).order("date asc")
  end

  # ----------------
  # Instance Methods
  # ----------------

  def applications
    career_interests.where("source='candidate'")
  end

  def registrations
    career_interests.where("source='registration_desk'")
  end

  def referrals
    career_interests.where("source='employee_referral'")
  end

end
