class CreateApiKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :api_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.string :key

      t.timestamps
    end
    add_index :api_keys, :key, unique: true
  end
end
