# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"
  has_many :comments
  has_one_attached :cover_image

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :category, presence: true

  # Definindo variantes diretamente no anexo
  def cover_image_thumb
    cover_image.variant(resize_to_limit: [ 325, 205 ]).processed
  end
end
