class RegistrationsMailer < ActionMailer::Base

	default from: "infoinspired11@gmail.com"

	def online_register(to_email, event_id, careers_interest_id)
		@to_email = to_email
		@event_id = event_id
		@careers_interest_id = careers_interest_id
		mail(:to=> to_email, :subject=>"Welcome to Qwinix Careers")
	end

	def volunteer_register(to_email)
		@to_email = to_email
		mail(:to=> to_email, :subject=>"Welcome to Qwinix Careers")
	end

	def referrals_register(to_email)
		@to_email = to_email
		mail(:to=> to_email, :subject=>"Welcome to Qwinix Careers")
	end
end
