class CreateArtisans < ActiveRecord::Migration[7.0]
  def change
    create_table :artisans do |t|
      t.string :siret

      t.timestamps
    end
  end
end
