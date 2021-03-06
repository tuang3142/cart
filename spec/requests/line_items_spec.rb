# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/line_items", type: :request do
  describe "POST /create" do
    it "creates line_item via ajax" do
      ruby_book = create(:product)

      post line_items_url, params: { product_id: ruby_book.id }, xhr: true

      expect(response).to have_http_status(:success)
      line_item_id = LineItem.last.id
      expect(response.body).to match /<tr id=line_item#{line_item_id} class=\\"line-item-highlight/
    end
  end
end
