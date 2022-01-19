class Item < ApplicationRecord
    has_and_belongs_to_many :tags

    validates_presence_of :name, :retail_price, :wholesale_price, :supplier
    validates_length_of :name, maximum: 70
    validates_length_of :supplier, maximum: 70
    validates_uniqueness_of :name, case_sensitive: false
end
