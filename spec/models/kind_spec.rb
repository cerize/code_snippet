require 'rails_helper'

RSpec.describe Kind, type: :model do

  let(:kind) { FactoryGirl.create(:kind) }

  describe "validations" do
    it "doesnt allow creating a kind with no name" do
      k = Kind.new
      k.valid?
      expect(k.errors).to have_key(:name)
    end
    it "requires a unique name" do
      k = Kind.new(name: kind.name)
      k.valid?
      expect(k.errors).to have_key(:name)
    end
  end
end
