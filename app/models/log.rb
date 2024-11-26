class Log < ApplicationRecord

  belongs_to :user
  has_many :log_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :log_tags, dependent: :destroy
  has_many :tags, through: :log_tags

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

  def get_image
    image.variant(resize_to_limit: [500, 500]).processed
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tags(savelog_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savelog_tags
    new_tags = savelog_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      log_tag = Tag.find_or_create_by(name:new_name)
      self.tags << log_tag
    end
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Log.where(title: content)
    elsif method == 'forward'
      Log.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Log.where('title LIKE ?', '%'+content)
    else
      Log.where('title LIKE ?', '%'+content+'%')
    end
  end

end
