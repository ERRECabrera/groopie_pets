class Pet < ActiveRecord::Base
  has_attached_file :image, styles: { thumb: "100x100>", zoom:"400x400>" }, default_url: "/images/:style/missing.png"
  
  validates_attachment_content_type :image, content_type: /\Aimage.*\Z/
  validates_attachment_presence :image, attachment_presence: true
  validates_attachment_size :image, :less_than => 15.megabyte

  validates :name, :animal, :user_id, presence: true
  validates :name, length: { maximum: 15 }
  ANIMAL_SPECIES = %w(cat dog bird fish reptile rodent exotic)
  validates :animal, inclusion: { in: ANIMAL_SPECIES }
  validates :age, numericality: {only_integer: true, greater_than: -1}

  belongs_to :user

  def self.animal_species
    ANIMAL_SPECIES
  end

  def self.return_with_criterial(array,key_sort,number_limit=nil)
    if number_limit
      array.order(key_sort).limit(number_limit)
    else
      array.order(key_sort)
    end
  end

  def name_user
    User.find_by_id(self.user_id).name
  end

  def images_urls
    images = {
      original: image.url(:original),
      zoom: image.url(:zoom),
      thumb: image.url(:thumb) 
    }    
  end

end
