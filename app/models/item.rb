class Item < ApplicationRecord
    has_and_belongs_to_many :tags

    validates_presence_of :name, :retail_price, :wholesale_price, :supplier
    validates_length_of :name, maximum: 70
    validates_length_of :supplier, maximum: 70
    validates_uniqueness_of :name, case_sensitive: false

    filterrific(
      # default_filter_params: { sorted_by: 'updated_at_desc' },
      available_filters: [
        # :sorted_by,
        :search_query,
        :with_tags,
        # :with_quantity,
        # :with_supplier,
      ]
    )

    scope :with_tags, ->(tag_name) {
      # tags_names = tag_names.split(",").map(&:strip)
      Tag.where(name: tag_name).items
    }

    scope :search_query, ->(query) {
      return nil  if query.blank?

      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)

      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        (e.tr("*", "%") + "%").gsub(/%+/, "%")
      }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conds = 3
      where(
        terms.map { |_term|
          or_clauses = [
            "LOWER(items.name) LIKE ?",
            "LOWER(items.desc) LIKE ?",
            "LOWER(items.supplier) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
    }

end
