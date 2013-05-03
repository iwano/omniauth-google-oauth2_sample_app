class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pic_url
      t.string :uid

      t.timestamps
    end
  end
end
