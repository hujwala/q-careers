require 'rails_helper'

RSpec.describe Event, type: :model do

let(:event1) {FactoryGirl.create(:event, :name => "Event1", :slug => "slug1")}
let(:event2) {FactoryGirl.create(:event, :name => "Event2", :slug => "slug2")}
let(:event3) {FactoryGirl.create(:event, :name => "Event3", :slug => "slug3")}

  context "Factory" do
    it "should validate all the event factories" do
      expect(FactoryGirl.build(:event).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :date }
    it { should validate_presence_of :slug }
    it { should validate_presence_of :venue }
    it { should allow_value('Mysore').for(:venue )}
    it { should_not allow_value('Mysore$%?').for(:venue )}
  end


  context "Class Methods" do
    it "search" do
      arr = [event1, event2, event3]
      expect(Event.search("Event1")).to match_array([event1])
      expect(Event.search("Event2")).to match_array([event2])
      expect(Event.search("Event3")).to match_array([event3])
    end
  end
end
