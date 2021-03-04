class Patient < ApplicationRecord
  has_many :cases
  has_many :users, through: :cases

  validates :first_name, :last_name, presence: true
  validates :gender, inclusion: { in: ['male', 'female'] }

  def age
    Date.today.year - self.date_of_birth.year
  end
end
