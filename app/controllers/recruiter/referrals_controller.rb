class Recruiter::ReferralsController < Poodle::AdminController

  before_filter :require_recruiter
  skip_before_filter :require_admin
  before_filter :get_event

  def download
    @referral = CareerInterest.find_by_id(params[:id])
    if ["production", "staging"].include?(Rails.env)
      redirect_to @referral.candidate.resume.url
    else
      send_file @referral.candidate.resume.path, :x_sendfile => true
    end
  end

  private

  def get_event
    @event = Event.find_by_id(params[:event_id])
  end

  def prepare_filters
    @filters = {}
    @filters[:year_of_passing] = params[:year_of_passing] unless params[:year_of_passing].blank?
    @filters[:current_city] = params[:current_city] unless params[:current_city].blank?
    @filters[:native_city] = params[:native_city] unless params[:native_city].blank?
    @filters[:confirmation] = params[:confirmation] unless params[:confirmation].blank?
    @filters[:reporting] = params[:reporting] unless params[:reporting].blank?
    @filters[:referrer_id] = params[:referrer_id] unless params[:referrer_id].blank?
  end

  def prepare_query
    prepare_filters
    @relation = @event.referrals.joins(:candidate).where("")
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
    @relation = @relation.where("candidates.year_of_passing = ?", @filters[:year_of_passing]) if @filters[:year_of_passing]
    @relation = @relation.where("candidates.current_city = ?", @filters[:current_city]) if @filters[:current_city]
    @relation = @relation.where("candidates.native_city = ?", @filters[:native_city]) if @filters[:native_city]
    @relation = @relation.where("career_interests.confirmed = ? ", @filters[:confirmation] == "Confirmed") if @filters[:confirmation]
    @relation = @relation.where("career_interests.reported = ? ", @filters[:reporting] == "Reported") if @filters[:reporting]
    @relation = @relation.where("career_interests.referrer_id = ? ", @filters[:referrer_id]) if @filters[:referrer_id]
  end

  def default_collection_name
    "referrals"
  end

  def default_item_name
    "referral"
  end

  def default_class
    CareerInterest
  end

  def set_navs
    set_nav("recruiter/career_interests")
    set_title("Employee Referrals | Q-Careers")
  end

end
