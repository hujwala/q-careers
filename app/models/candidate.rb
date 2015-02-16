class Candidate < ActiveRecord::Base

  # Associations
  has_many :career_interests
  has_many :events, through: :career_interests

  # Constants
  CURRENT_YEAR = Date.today.year
  YEAR_OF_PASSING_LIST = (CURRENT_YEAR-2..CURRENT_YEAR).to_a
  YEARS_LIST = (1..25).to_a
  COUNTRY_LIST = ["India", "United States", "United Arab Emirates", "Costa Rica"]

  # Validations
  extend PoodleValidators

  validate_string :name, mandatory: true
  validate_email :email
  validate_string :phone, mandatory: true, min_length: 8, max_length: 16, format: /.*/i
  validate_string :current_city, mandatory: true, max_length: 128
  validate_string :current_state, mandatory: true, max_length: 128
  validate_string :current_country, mandatory: true, max_length: 128
  validate_string :native_city, mandatory: true, max_length: 128
  validate_string :native_state, mandatory: true, max_length: 128
  validate_string :native_country, mandatory: true, max_length: 128
  validate_string :skills, mandatory: true, max_length: 512

  validates :current_country, :inclusion => {:in => COUNTRY_LIST, :message => "%{value} is not a valid country" }
  validates :native_country, :inclusion => {:in => COUNTRY_LIST, :message => "%{value} is not a valid country" }
  validates :year_of_passing, :inclusion => {:in => YEAR_OF_PASSING_LIST, :message => "Sorry. You seems to be an experienced person. You cannot apply as a fresher." }
  validates :experience_in_years, :inclusion => {:in => YEARS_LIST, :message => "%{value} is not a valid no of years" }

  validates :resume, presence: true

  # File Uploader Method Hook
  mount_uploader :resume, ResumeUploader

end
