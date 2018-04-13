class Order < ApplicationRecord
  belongs_to :showtime
  has_one :movie, through: :showtime
  after_save :send_confirmation

  validates :email, :name, :quantity, presence: true
  validate :seats_available

  def seats_available
    if quantity > showtime.number_of_seats_available
      errors.add(:quantity, 'unavailable')
    end
  end

  def send_confirmation
    ConfirmationNotifier.successful_order(self).deliver
  end

  def total_price
    quantity * showtime.price
  end
end
