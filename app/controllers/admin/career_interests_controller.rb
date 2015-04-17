class Admin::CareerInterestsController < Poodle::AdminController

  before_filter :get_event
  before_filter :get_career_interest, only: :download

  def download
    send_file @career_interest.candidate.resume.path, :x_sendfile => true
  end

  private

  def default_collection_name
    "career_interests"
  end

  def default_item_name
    "career_interest"
  end

  def default_class
    CareerInterest
  end

  def prepare_filters
    @filters = {}
    @filters[:year_of_passing] = params[:year_of_passing] unless params[:year_of_passing].blank?
    @filters[:current_city] = params[:current_city] unless params[:current_city].blank?
    @filters[:native_city] = params[:native_city] unless params[:native_city].blank?
  end

  def prepare_query
    prepare_filters
    @relation = @event.career_interests.joins(:candidate).where("")
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
    @relation = @relation.where("candidates.year_of_passing = ?", @filters[:year_of_passing]) if @filters[:year_of_passing]
    @relation = @relation.where("candidates.current_city = ?", @filters[:current_city]) if @filters[:current_city]
    @relation = @relation.where("candidates.native_city = ?", @filters[:native_city]) if @filters[:native_city]
  end

  def get_event
    @event = Event.find_by_id(params[:event_id])
  end

  def get_career_interest
    @career_interest = CareerInterest.find_by_id(params[:id])
  end

  def set_navs
    set_nav("admin/events")
  end

end
