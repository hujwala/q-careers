class ReportsController < ApplicationController

  layout 'poodle/application'
  before_filter :set_navs, :parse_pagination_params
  before_filter :require_volunteer, only: :registrations

  def registrations
    @relation = CareerInterest.joins(:candidate).where("reported is true")
    @career_interests = @relation.order("reported_at desc").page(@current_page).per(@per_page)
    @total_count = @relation.count
  end

  private

  def set_navs
    set_nav("reports")
    set_title("Reports | Q-Careers")
  end

end
