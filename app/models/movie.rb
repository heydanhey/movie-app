class Movie < ApplicationRecord
  has_many :showtimes
  has_many :orders, through: :showtimes

  def self.showing_today(date)
    joins(:showtimes)
    .select('DISTINCT movies.*')
    .where('showtimes.time > ? AND showtimes.time < ?', "%#{date.beginning_of_day}%", "%#{date.end_of_day}%")
    .order('title')
  end

  def has_showtimes_today?(date)
    showtimes.collect{|o| o.time.to_date == date }.any?
  end
end
