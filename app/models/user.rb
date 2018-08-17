class User < ApplicationRecord
  has_many :restaurants
  has_many :orders
  has_many :suggests, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
           foreign_key: :user_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :relationships, dependent: :destroy
  has_many :restaurants, through: :relationships

  enum role: [:user, :manager, :admin]

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  scope :load_data, ->{select(:id, :name, :email, :address, :phone_number, :role).order :name}
  scope :activated_user, ->{where(activated: true)}

  validates :name, presence: true,
            length: {maximum: Settings.model.users.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            length: {maximum: Settings.model.users.email.maximum},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :address, presence: true,
            length: {maximum: Settings.model.users.address.maximum}
  validates :phone_number, presence: true,
            length: {maximum: Settings.model.users.phone.maximum}
  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.model.users.password.minimum},
            allow_nil: true

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? user
    user == self
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
                      reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.timeout.reset_sent.hours.ago
  end

  def follow restaurant
    following << restaurant
  end

  def unfollow restaurant
    following.delete restaurant
  end

  def following? restaurant
    following.include? restaurant
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
