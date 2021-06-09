# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, length: { minimum: 10 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpeg|jpg|png)\z}i,

    message: "must be a URL for GIF, JPG, JPEG, or PNG image."
  }

  before_destroy :ensure_not_referenced_by_any_line_item
  has_many :line_items # TODO: dependent

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, "is referenced by a LineItem")
    throw :abort
  end
end
