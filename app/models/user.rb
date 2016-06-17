class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :activities, dependent: :destroy
  has_many :lessions, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy											
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :followed
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "avatar/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/png", "image/gif"]},
    size: { in: 0..2048.kilobytes }
  validates :email, presence: true, length: {maximum: 235},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  
  before_save :downcase_email
  has_secure_password

  private
  def downcase_email
    self.email = email.downcase
  end
end
