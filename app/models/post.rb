class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(attributes)
    attributes.values.each do |attribute|
      if attribute["name"] != ""
        category = Category.find_or_create_by(attribute)
        self.categories << category
      end
    end
  end

  def commenters
    self.comments.map{|comment|comment.user}.uniq
  end

end
