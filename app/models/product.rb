class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }
  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }

  validate :acceptable_image

  def acceptable_image
    return unless image.attached?

    acceptable_types = [ "image/jpeg", "image/png", "image/gif" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be GIF, JPG, or PNG image")
    end
  end

  private

    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "line items present")
        throw :abort
      end
    end
end
