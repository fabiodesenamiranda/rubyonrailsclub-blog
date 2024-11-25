# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :cover_image

  # Definindo variantes diretamente no anexo
  def cover_image_thumb
    cover_image.variant(resize_to_limit: [ 100, 100 ]).processed
  end

  def cover_image_cover
    cover_image.variant(resize_to_limit: [ 200, 200 ]).processed
  end
end
