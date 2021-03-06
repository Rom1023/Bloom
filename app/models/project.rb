class Project < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :links
  has_many :cases, through: :links
  has_many :users, through: :collaborations
  has_many :comments

  # validates :collaborations, presence: true

  default_scope { order("created_at DESC") }
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
                  against: [:name, :description],
                  using: {
                    tsearch: { prefix: true }
                  }

  def is_admin?(user_id)
    admin = collaborations.find_by(role: 'admin', user_id: user_id)
    admin.presence
  end

  def my_collaborations
    collaborations.project_collaborations
  end

  def creator_collaborations
    collaborations.project_creator
  end
end
