require 'rails_helper'

RSpec.describe CareerInterest, type: :model do

let(:career_interest) {FactoryGirl.create(:career_interest)}

  context "Factory" do
    it "should validate all the career_interest factories" do
      expect(FactoryGirl.build(:career_interest).valid?).to be true
    end
  end

  context "Associations" do
    it { should belong_to(:candidate) }
    it { should belong_to(:event) }
  end

  context "Validations" do
    it { should validate_presence_of :candidate }
    it { should validate_presence_of :event }
  end

end
