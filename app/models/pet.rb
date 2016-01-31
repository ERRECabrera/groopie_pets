class Pet < ActiveRecord::Base

  after_find :instance_variables

  cattr_reader :animal_species
  @@animal_species = %w(cat dog bird fish reptile rodent exotic)

  has_attached_file :image, styles: { thumb: "100x100>", zoom:"400x400>" }, default_url: "/images/:style/missing.png"
  
  validates_attachment_content_type :image, content_type: /\Aimage.*\Z/
  validates_attachment_presence :image, attachment_presence: true
  validates_attachment_size :image, :less_than => 15.megabyte

  attr_reader :user_name, :images_urls, :age

  def instance_variables
    @user_name = user.name
    @images_urls = {
      original: image.url(:original),
      zoom: image.url(:zoom),
      thumb: image.url(:thumb) 
    }
    @age = return_age_string
  end

  validates :name, :animal, :user_id, presence: true
  validates :name, length: { maximum: 15 }
  validates :animal, inclusion: { in: @@animal_species }
  validates_date :birth, :on_or_before => :today

  belongs_to :user

  scope :desc_sorted_by_id, -> { all.order({id: :desc}) }

  def return_age_string
    if self.birth
      number_years = Date.today.year - self.birth.year
      number_months = Date.today.month - self.birth.month

      #this condition fix when the year has changed but days < 364
      range_date = self.birth..Date.today
      number_days = range_date.reduce(0) {|s,d| s + 1}
      condition_below_a_year_fix = number_days < 364

      #this condition show when age < month
      condition_below_a_month_fix = Date.today.day < self.birth.day && number_months <= 1 

      if number_months == 0 && number_years == 0
        age_string = "#{number_days} days"
      elsif number_years == 0 || condition_below_a_year_fix
        if condition_below_a_month_fix
          age_string = "#{number_days} days"
        else
          number_months = 12 - number_months.abs if number_months < 0
          age_string = "#{number_months} months"
        end
      else
        age_string = "#{number_years} years"
      end
    else
      age_string = 'unknowed'
    end
  end

end
