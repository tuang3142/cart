require "rails_helper"

RSpec.describe Product, type: :model do
  describe ".title" do
    it "should have at least 10 characters" do
      product = create(:product)
      expect(product).to be_valid
    end
  end
end
