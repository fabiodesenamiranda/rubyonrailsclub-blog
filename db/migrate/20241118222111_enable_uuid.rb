# frozen_string_literal: true

# db/migrate/20241118222111_enable_uuid.rb
class EnableUuid < ActiveRecord::Migration[8.0]
  def change
    enable_extension("pgcrypto")
  end
end
