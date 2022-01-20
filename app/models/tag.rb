class Tag < ApplicationRecord
    has_and_belongs_to_many :items
    validates_uniqueness_of :name, case_sensitive: false
end
