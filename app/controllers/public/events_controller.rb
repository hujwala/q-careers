class Public::EventsController < Public::BaseController

  def index
    @relation = Event.where("")
    @events = @relation.order("created_at desc").page(@current_page).per(@per_page)
  end

  def show
    @event = Event.find_by_slug(params[:id])
    @career_interest = CareerInterest.new
    @fresher = Fresher.new
  end

  def apply
    @event = Event.find_by_id(params[:id])
    @fresher = Fresher.fetch(fresher_params)
    @career_interest = CareerInterest.fetch(@event, @fresher)
    @career_interest.source = :candidate

    # FIXME - Params are passed now some odd way.
    @fresher.year_of_passing = params[:fresher][:candidate][:year_of_passing]
    if @fresher.save && @career_interest.save
      RegistrationsMailer.online_registration(@career_interest).deliver_now
      redirect_to public_event_career_interest_path(event_id: @event.slug, id: @career_interest.id)
    else
      render action: :show
    end
  end

  private

  def fresher_params
    params[:fresher].permit(:name, :email, :phone, :current_city, :native_city, :year_of_passing, :resume )
  end

  def set_navs
    set_nav("public/events")
  end

end

