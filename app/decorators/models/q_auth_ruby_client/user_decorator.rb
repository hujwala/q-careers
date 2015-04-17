QAuthRubyClient::User.class_eval do
  # * Return address which includes city, state & country
  # == Examples
  #   >>> candidate.display_address(type)
  #   => "Mysore, Karnataka, India"
  def display_q_careers_role
    self.q_careers_role.split("_").map{|x| x.capitalize}.join(" ")
  end

  def is_q_careers_admin?
    self.q_careers_role == "q_careers_admin"
  end

  def is_recruiter?
    ["q_careers_admin", "recruiter"].include?(self.q_careers_role)
  end

  def is_volunteer?
    ["q_careers_admin", "recruiter", "volunteer"].include?(self.q_careers_role)
  end

end
