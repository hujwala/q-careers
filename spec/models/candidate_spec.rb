require 'rails_helper'

RSpec.describe Candidate, :type => :model do

  let(:candidate) {FactoryGirl.create(:candidate)}

  context "Factory" do
    it "should validate all the candidate factories" do
      expect(FactoryGirl.build(:candidate).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Krishnaprasad Varma').for(:name )}
    it { should_not allow_value('KP').for(:name )}
    it { should_not allow_value("x"*257).for(:name )}

    it { should validate_presence_of :email }
    it { should allow_value('something@domain.com').for(:email )}
    it { should_not allow_value('something domain.com').for(:email )}
    it { should_not allow_value('something.domain.com').for(:email )}
    it { should_not allow_value('ED').for(:email )}
    it { should_not allow_value("x"*257).for(:email )}

    it { should validate_presence_of :phone }
    it { should validate_presence_of :current_city }
    it { should validate_presence_of :current_state }
    it { should validate_presence_of :current_country }
    it { should validate_presence_of :native_city }
    it { should validate_presence_of :native_state }
    it { should validate_presence_of :native_country }
    it { should validate_presence_of :skills }
    it { should validate_presence_of :resume }


    it { should validate_inclusion_of(:current_country).in_array(Candidate::COUNTRY_LIST)  }
    it { should validate_inclusion_of(:native_country).in_array(Candidate::COUNTRY_LIST)  }
    it { should validate_inclusion_of(:year_of_passing).in_array(Candidate::YEAR_OF_PASSING_LIST)  }
    it { should validate_inclusion_of(:experience_in_years).in_array(Candidate::YEARS_LIST)  }

  end

  it "should validate phone length" do

    candidate.phone = "9901"
    candidate.valid?
    expect(candidate.errors[:phone].size).to be 1
    expect(candidate).to be_invalid

    candidate.phone = "9901916142"*257
    candidate.valid?
    expect(candidate.errors[:phone].size).to be 1
    expect(candidate).to be_invalid

    candidate.phone = "9901916142"
    candidate.valid?
    expect(candidate.errors[:phone].size).to be 0
    expect(candidate).to be_valid
  end

  it "should validate current_city length" do

    candidate.current_city = "Mysore"*128
    candidate.valid?
    expect(candidate.errors[:current_city].size).to be 1
    expect(candidate).to be_invalid

    candidate.current_city = "Mysore"
    candidate.valid?
    expect(candidate.errors[:current_city].size).to be 0
    expect(candidate).to be_valid
  end

  it "should validate current_state length" do

    candidate.current_state = "Karnataka"*128
    candidate.valid?
    expect(candidate.errors[:current_state].size).to be 1
    expect(candidate).to be_invalid

    candidate.current_state = "Karnataka"
    candidate.valid?
    expect(candidate.errors[:current_state].size).to be 0
    expect(candidate).to be_valid
  end

  it "should validate current_country length" do

    candidate.current_country = "India"*128
    candidate.valid?
    expect(candidate.errors[:current_country].size).to be 2
    expect(candidate).to be_invalid

    candidate.current_country = "India"
    candidate.valid?
    expect(candidate.errors[:current_country].size).to be 0
    expect(candidate).to be_valid
  end

  it "should validate native_city length" do

    candidate.native_city = "Mysore"*128
    candidate.valid?
    expect(candidate.errors[:native_city].size).to be 1
    expect(candidate).to be_invalid

    candidate.native_city = "Mysore"
    candidate.valid?
    expect(candidate.errors[:native_city].size).to be 0
    expect(candidate).to be_valid
  end

  it "should validate native_state length" do

    candidate.native_state = "Karnataka"*128
    candidate.valid?
    expect(candidate.errors[:native_state].size).to be 1
    expect(candidate).to be_invalid

    candidate.native_state = "Karnataka"
    candidate.valid?
    expect(candidate.errors[:native_state].size).to be 0
    expect(candidate).to be_valid
  end

  it "should validate native_country length" do

    candidate.native_country = "India"*128
    candidate.valid?
    expect(candidate.errors[:native_country].size).to be 2
    expect(candidate).to be_invalid

    candidate.native_country = "India"
    candidate.valid?
    expect(candidate.errors[:native_country].size).to be 0
    expect(candidate).to be_valid
  end
end