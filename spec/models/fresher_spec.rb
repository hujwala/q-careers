require 'rails_helper'

RSpec.describe Fresher, :type => :model do

  let(:fresher) {FactoryGirl.create(:fresher)}

  context "Factory" do
    it "should validate all the fresher factories" do
      expect(FactoryGirl.build(:fresher).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_inclusion_of(:year_of_passing).in_array(Candidate::YEAR_OF_PASSING_LIST)}
  end

end