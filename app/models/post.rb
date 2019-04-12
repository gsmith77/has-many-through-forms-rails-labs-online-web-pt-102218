class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories

  def categories_attributes=(categories_hashes)
    # {"0"=>{"name"=>"new post 1"}, "1"=>{"name"=>" new post 2"}}
    categories_hashes.values.each do |category_hash|
      if category_hash[:name].present?
        category = Category.find_or_create_by(name: category_hash[:name])
        if !self.categories.include?(category)
          self.post_categories.build(:category => category)
        end
      end
    end
  end


end
