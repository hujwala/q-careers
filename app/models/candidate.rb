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

  validate_string :current_city, mandatory: true, max_length: 128, format: /.*/i
  #validate_string :current_state, mandatory: true, max_length: 128, format: /.*/i
  #validate_string :current_country, mandatory: true, max_length: 128, format: /.*/i
  validate_string :native_city, mandatory: true, max_length: 128, format: /.*/i
  #validate_string :native_state, mandatory: true, max_length: 128, format: /.*/i
  #validate_string :native_country, mandatory: true, max_length: 128, format: /.*/i
  validate_string :skills, mandatory: true, max_length: 512, format: /.*/i

  #validates :current_country, :inclusion => {:in => COUNTRY_LIST, :message => "%{value} is not a valid country" }
  #validates :native_country, :inclusion => {:in => COUNTRY_LIST, :message => "%{value} is not a valid country" }

  validates :resume, presence: true

  # File Uploader Method Hook
  mount_uploader :resume, ResumeUploader

  # Class Methods
  def self.fetch(params)
    if params[:email]
      fresher = Fresher.find_by_email(params[:email])
    end
    fresher = Fresher.new(params) unless fresher
    fresher
  end

  # Instance Methods
  def namify
    self.name.split(" ").map{|x| x.first.capitalize}[0..2].join("")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_current_address
  #   => "Mysore, Karnataka, India"
  def display_current_address
    address_list = []
    address_list << current_city unless current_city.blank?
    address_list << current_state unless current_state.blank?
    address_list << current_country unless current_country.blank?
    address_list.join(", ")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_native_address
  #   => "Mysore, Karnataka, India"
  def display_native_address
    address_list = []
    address_list << native_city unless native_city.blank?
    address_list << native_state unless native_state.blank?
    address_list << native_country unless native_country.blank?
    address_list.join(", ")
  end

end
