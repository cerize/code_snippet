require 'rails_helper'

RSpec.describe Snippet, type: :model do

  let(:snippet) { FactoryGirl.create(:snippet) }

  describe "validations" do
    it "doesnt allow creating a snippet with no title" do
      s = Snippet.new
      s.valid?
      expect(s.errors).to have_key(:title)
    end

    it "doesnt allow creating a snippet with no work" do
      s = Snippet.new
      s.valid?
      expect(s.errors).to have_key(:work)
    end

    it "requires a unique title" do
      s = Snippet.new(title: snippet.title)
      s.valid?
      expect(s.errors).to have_key(:title)
    end
  end
end
