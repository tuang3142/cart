# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/line_items", type: :request do
  describe "POST /create" do
    it "create line_item via ajax" do
      ruby_book = create(:product)

      post line_items_url, params: { product_id: ruby_book.id }, xhr: true

      expect(response).to have_http_status(:success)
    end
  end
end
