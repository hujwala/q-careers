class Candidate < ActiveRecord::Base

  # Associations
  has_many :career_interests
  has_many :events, through: :career_interests

  # Constants
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
  # -------------

  # * Return candidate which matches the email else will build a new one with the passed email
  # == Examples
  #   >>> Fresher.fetch("some@email.com")
  #   >>> Experienced.fetch("some@email.com")
  #   => <Fresher Active Record Object>
  def self.fetch(params)
    fresher = Fresher.find_by_email(params[:email]) if params[:email]
    fresher = Fresher.new(params) unless fresher
    fresher
  end

  # Instance Methods
  # ----------------

  # * Return the first letters of first name and last name
  # == Examples
  #   >>> fresher = Fresher.new(name: "Ravi Shankar")
  #   >>> fresher.namify
  #   => "RS"
  def namify
    self.name.split(" ").map{|x| x.first.capitalize}[0..1].join("")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_address(type)
  #   => "Mysore, Karnataka, India"
  def display_address(type)
    [self.send("#{type}_city"), self.send("#{type}_state"), self.send("#{type}_country")].compact.uniq.join(", ")
    #address_list << send.("#{type}_city") unless send.("#{type}_city").blank?
    #address_list << send.("#{type}_state") unless send.("#{type}_state").blank?
    #address_list << send.("#{type}_country") unless send.("#{type}_country").blank?
    #address_list.join(", ")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_current_address
  #   => "Mysore, Karnataka, India"
  def display_current_address
    display_address(:current)
    # address_list = []
    # address_list << current_city unless current_city.blank?
    # address_list << current_state unless current_state.blank?
    # address_list << current_country unless current_country.blank?
    # address_list.join(", ")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_native_address
  #   => "Mysore, Karnataka, India"
  def display_native_address
    display_address(:native)
    # address_list = []
    # address_list << native_city unless native_city.blank?
    # address_list << native_state unless native_state.blank?
    # address_list << native_country unless native_country.blank?
    # address_list.join(", ")
  end

end
