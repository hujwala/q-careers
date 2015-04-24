class ReportsController < ApplicationController

  layout 'poodle/application'
  before_filter :set_navs, :parse_pagination_params
  before_filter :require_volunteer, only: :registrations

  def registrations
    @relation = CareerInterest.joins(:candidate).where("reported is true")
    @career_interests = @relation.order("reported_at desc").page(@current_page).per(@per_page)
    @total_count = @relation.count
  end

  def referrals

    # select max(ci.referrer_id) as rid, 
    #        max(u.name) as name, 
    #        count(ci.id) as total, 
    #        count(case when ci.confirmed is true then 1 end) as confirmed, 
    #        count(case when ci.reported is true then 1 end) as reported 
    # from career_interests ci 
    # inner join users u 
    #  on u.id = ci.referrer_id 
    # group by ci.referrer_id;

    @career_interests = CareerInterest.select("max(career_interests.referrer_id) as rid, 
           max(u.name) as name, 
           count(career_interests.id) as total_count, 
           count(case when career_interests.confirmed is true then 1 end) as confirmed_count, 
           count(case when career_interests.reported is true then 1 end) as reported_count").joins("inner join users u on u.id = career_interests.referrer_id ").group("career_interests.referrer_id")
  end

  private

  def set_navs
    set_nav("reports")
    set_title("Reports | Q-Careers")
  end

end
