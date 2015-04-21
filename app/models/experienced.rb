class Experienced < Candidate

  # Constants
  YEARS_LIST = (1..25).to_a
  validates :experience_in_years, :inclusion => {:in => YEARS_LIST, :message => "Please select from the list" }

  # Class Methods
  # -------------

  # * Return experienced candidate which matches the email else will build a new one with the passed email
  # == Examples
  #   >>> Experienced.fetch("some@email.com")
  #   => <Experienced Active Record Object>
  def self.fetch(params)
    experienced = Experienced.find_by_email(params[:email]) if params[:email]
    experienced = Experienced.new(params) unless experienced
    experienced
  end

end
