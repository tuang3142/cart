# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  describe ".title" do
    it "has at least 10 characters" do
      product = create(:product)
      expect(product).to be_valid
    end
  end
end
