# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'bcrypt'
class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true
  validates :password, length: {minimum: 4, allow_nil: true}
  attr_reader :password
  after_initialize :ensure_session_token

  has_many :hubs,
  foreign_key: :author_id,
  class_name: 'Hub'

  has_many :posts,
  foreign_key: :author_id,
  class_name: 'Post'

  has_many :comments,
  foreign_key: :author_id,
  class_name: 'Comment'

  def self.generate_session_token
    SecureRandom.base64
  end

  def self.find_by_credentials(email, password)
    found_user = User.find_by_email(email)
    return nil if found_user.nil?
    found_user.is_password?(password) ? found_user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
