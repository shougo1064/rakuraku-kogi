# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :homeworks, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :message_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followings, through: :follows, source: :follower

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 30 }
end
