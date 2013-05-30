require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreateCongressPeople < ActiveRecord::Migration
  def change
    create_table :congress_people do |t|
      t.string :title
      t.string :firstname
      t.string :middlename                  
      t.string :lastname
      t.string :name_suffix                  
      t.string :name
      t.string :webform
      t.string :phone
      t.string :fax
      t.string :website
      t.string :party
      t.string :gender
      t.string :state
      t.string :twitter_id
      t.date    :birthdate
      t.integer :in_office
    end
  end
end
