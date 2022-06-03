# frozen_string_literal: true

class User < ApplicationRecord
  include Followable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "format is invalid"


  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    end
  end

  def is_owner?(post, current_user)
    post.user.id == current_user.id
  end
end
