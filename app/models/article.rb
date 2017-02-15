class Article < ApplicationRecord
    
    belongs_to :user
    has_many :comments
    
    
    validates :title, presence: true
    validates :body, presence: true
    validates_length_of :body, minimum: 5
    validates_uniqueness_of :title
    before_save :set_visits_count
    after_create :save_categories
    
    has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
    
    def categories=(value)
        @categories = value
    end
    
    def update_visits_count
        self.update(visits_count: self.visits_count + 1)  
        puts "++++++++++++++++++"
        puts self.errors.inspect
        puts "++++++++++++++++++"
    end
    private  
    
    def save_categories
        @categories.each do |category_id|
            HasCategory.create(category_id: category_id,article_id: self.id)
        end
    end
    
    def set_visits_count
        if self.visits_count ||= 0        
        end
    end
end
