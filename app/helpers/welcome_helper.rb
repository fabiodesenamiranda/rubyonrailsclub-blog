# frozen_string_literal: true

module WelcomeHelper
  def cover_image_fallback(article)
    if article.cover_image.attached?
      article.cover_image.variant(resize_to_limit: [ 100, 100 ]).processed
    else
      "posts/post1.jpg"
    end
  end
end
