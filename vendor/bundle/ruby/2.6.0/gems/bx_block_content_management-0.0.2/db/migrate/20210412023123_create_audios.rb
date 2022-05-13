class CreateAudios < ActiveRecord::Migration[6.0]
  def change
    create_table :audios do |t|
      t.integer :attached_item_id, index: true
      t.string :attached_item_type, index: true
      t.string :audio

      t.timestamps
    end
  end
end
