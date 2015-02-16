class Event < ActiveRecord::Base

  # Associations
  has_many :career_interests
  has_many :candidates, through: :career_interests

  # Validations
  extend PoodleValidators

  validate_string :name, mandatory: true
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

end
