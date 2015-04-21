class RegistrationsMailer < ActionMailer::Base

	default from: "careers@qwinixtech.com"

	def online_registration(careers_interest)
		@careers_interest = careers_interest
		receiver = @careers_interest.candidate.email
		@event = @careers_interest.event
		mail(:to=> receiver, :subject=>"Qwinix Careers: #{@event.name}")
	end

	def registration_desk(careers_interest)
		@careers_interest = careers_interest
		@event = @careers_interest.event
		receiver = careers_interest.candidate.email
		mail(:to=> receiver, :subject=>"Qwinix Careers: Kindly upload your resume.")
	end

	def employee_referral(careers_interest)
		@careers_interest = careers_interest
		@referrer = careers_interest.referrer
		@event = @careers_interest.event
		receiver = careers_interest.candidate.email
		mail(:to=> receiver, :subject=>"Qwinix Careers: You have been referred")
	end
end
