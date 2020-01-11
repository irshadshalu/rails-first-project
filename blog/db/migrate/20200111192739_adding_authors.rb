class AddingAuthors < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :user, foreign_key: true, index: true
  end
end
