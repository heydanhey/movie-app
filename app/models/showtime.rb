class Showtime < ApplicationRecord
  belongs_to :movie
  belongs_to :theater
  has_many :orders

  def is_not_sold_out?
    number_of_seats_available > 0
  end

  def is_sold_out?
    number_of_seats_available <= 0
  end

  def is_today?(date)
    time.to_date == date
  end

  def number_of_seats_available
    theater.capacity - orders.sum('quantity')
  end

  def pretty_time
    time.strftime('%b %e, %l:%M %p')
  end
end
