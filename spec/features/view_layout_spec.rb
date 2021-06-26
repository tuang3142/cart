# frozen_string_literal: true

require "rails_helper"

describe "view layout" do
  it "is in every page" do
    visit store_index_url
    expect(page).to have_css("nav.side_nav a", minimum: 4)

    visit products_url
    expect(page).to have_css("nav.side_nav a", minimum: 4)
  end
end
