class Item < ApplicationRecord
    validates_presence_of :name, :retail_price, :wholesale_price, :supplier
    validates_length_of :name, maximum: 70
    
end
