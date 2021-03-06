class Puddle < ApplicationRecord
  belongs_to :driver
  has_many :puddle_passengers
  has_many :passengers, through: :puddle_passengers
  validates :seats, numericality: { greater_than: -1 }

  def passenger_list
    self.passengers.joins(user: :profiles)
  end

  def driver_name
    self.driver.user.profiles.first.name
  end

  def formatted_departure_time
    self.departure_time.strftime("%A - %m/%d/%Y - %I:%M %p")
  end

  def formatted_departure_time_day
    self.departure_time.strftime("%A")
  end

  def formatted_departure_time_date
    self.departure_time.strftime("%m/%d/%Y")
  end

  def formatted_departure_time_time
    self.departure_time.strftime("%I:%M %p")
  end

  def driver_phone
    self.driver.user.profiles.first.phone
  end

  def driver_address
    self.driver.user.profiles.first.address
  end

  def driver_info
    results = []
    results << driver_name
    results << driver_address
    results << driver_phone
    results
  end

  def driver_id
    self.driver.user.id
  end

  def passenger_ids
    self.passengers.pluck(:user_id)
  end

  def destination
    Location.find(self.driver.user.profiles.first.location).name
  end

  # def upcoming_puddles
  #  self.puddles.where("departure_time > ?", DateTime.now)
  # end

end
