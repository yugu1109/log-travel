class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :logs, dependent: :destroy

  validates :name, presence: true
  validates :age, presence: true

  def status
    if gender == true
      "男性"
    else
      "女性"
    end
  end

  def active_for_authentication?
    super && (is_active == true)
  end

end
