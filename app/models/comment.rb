# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true
  validates_length_of :body, maximum: 100
end
