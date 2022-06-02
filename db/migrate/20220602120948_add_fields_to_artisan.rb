class AddFieldsToArtisan < ActiveRecord::Migration[7.0]
  def change
    add_column :artisans, :name, :string
    add_column :artisans, :activite, :string
    add_column :artisans, :adresse, :string
    add_column :artisans, :etat, :string
    add_column :artisans, :categorie, :string
    add_column :artisans, :date_creation, :string
    add_column :artisans, :date_verification, :string
  end
end
