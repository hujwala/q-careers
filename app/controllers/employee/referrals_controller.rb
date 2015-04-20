class Employee::ReferralsController < Poodle::AdminController

  before_filter :get_event
  skip_before_filter :require_admin

  def new
    @candidate = Candidate.new
    super
  end

  def create
    @candidate = Candidate.new(permitted_params)
    # FIXME - Params are passed now some odd way.
    @candidate.year_of_passing = params[:candidate][:candidate][:referral][:year_of_passing]

    @referral = CareerInterest.new(event: @event, candidate: @candidate, referrer: current_user)

    if @candidate.save && @referral.save
      flash[:success] = "Successfully saved the data."
      redirect_to employee_event_referral_path(@event, @referral)
    else
      flash[:error] = "Error! The email/phone is already registered with us."
      redirect_to employee_event_referrals_path(@event)
    end
  end

  def edit
    @referral = CareerInterest.find_by_id(params[:id])
    @candidate = @referral.candidate
  end

  def update
    @referral = CareerInterest.find_by_id(params[:id])
    @candidate = @referral.candidate
    @referral.referrer = current_user
    @candidate.assign_attributes(permitted_params)

    # FIXME - Params are passed now some odd way.
    @candidate.year_of_passing = params[:candidate][:candidate][:referral][:year_of_passing]

    if @candidate.save && @referral.save
      redirect_to employee_event_referral_path(@event, @referral)
    else
      redirect_to employee_event_referrals_path(@event)
    end
  end

  def download
    @referral = CareerInterest.find_by_id(params[:id])
    send_file @referral.candidate.resume.path, :x_sendfile => true
  end

  private

  def get_event
    @event = Event.find_by_id(params[:event_id])
  end

  def prepare_query
    @relation = @event.referrals.joins(:candidate).where("referrer_id = #{current_user.id}")
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
  end

  def permitted_params
    params[:candidate].permit(:name, :email, :phone, :current_city, :native_city, :year_of_passing, :resume )
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
    set_nav("employee/referrals")
    set_title("My Referrals | Q-Careers")
  end

end
