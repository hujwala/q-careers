require 'rails_helper'

RSpec.describe Experienced, :type => :model do

  let(:experienced) {FactoryGirl.create(:experienced)}

  context "Factory" do
    it "should validate all the experienced factories" do
      expect(FactoryGirl.build(:experienced).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_inclusion_of(:experience_in_years).in_array(Experienced::YEARS_LIST)}
  end

end