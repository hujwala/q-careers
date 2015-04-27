class Recruiter::EventsController < Poodle::AdminController

  before_filter :require_recruiter
  skip_before_filter :require_admin

  private

  def default_collection_name
    "events"
  end

  def default_item_name
    "event"
  end

  def default_class
    Event
  end

  def prepare_query
    # .where("date >= ?", Date.today)
    @relation = Event.where("slug != ?", 'qwinix-careers').order("date asc")
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
  end

  def set_navs
    set_nav("recruiter/career_interests")
    set_title("Career Interests | Q-Careers")
  end

end
