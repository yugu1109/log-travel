class Log < ApplicationRecord

  belongs_to :user

  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validates :price, presence: true
  validates :public_order, presence: true
  validates :meal, presence: true

  enum price: { too_expensive: 0, expensive: 1, ordinarily_price: 2, cheep: 3, too_cheep: 4 }
  enum public_order: { great_public: 0, good_public: 1, ordinarily_public: 2, bad_public: 3, worst_public: 4 }
  enum meal: { great_meal: 0, good_meal: 1, ordinarily_meal: 2, bad_meal: 3, worst_meal: 4 }

end
