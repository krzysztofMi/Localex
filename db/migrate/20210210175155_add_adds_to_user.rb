class AddAddsToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :advertisements, :user, foreign_key: true, null: false
  end
end
