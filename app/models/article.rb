class Article < ApplicationRecord
    include AASM
    
    belongs_to :user
    has_many :comments
    has_many :has_categories
    has_many :categories, through: :has_categories
    
    
    validates :title, presence: true
    validates :body, presence: true
    validates_length_of :body, minimum: 5
    validates_uniqueness_of :title
    before_save :set_visits_count
    after_create :save_categories
    
    has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
    
    scope :publicados, ->{ where(state: "published")}
    
    scope :ultimos, ->{order("created_at DESC")}
    
    #custom setter
    def categories=(value)
        @categories = value
    end
    
    def update_visits_count
        self.update(visits_count: self.visits_count + 1)  
        puts "++++++++++++++++++"
        puts self.errors.inspect
        puts "++++++++++++++++++"
    end
    
    aasm column: "state" do
        state :in_draft, :initial => true
        state :published
        
        event :publish do
            transitions :from => :in_draft, :to => :published
        end
        
        event :unpublish do
            transitions :from => :published, :to => :in_draft
        end
    end
    
    private  
    #lo que se ejecuta despues de crear el articulo
    def save_categories
        unless @categories.nil?
            @categories.each do |category_id|
                HasCategory.create(category_id: category_id,article_id: self.id)
            end
        end
    end
    
    def set_visits_count
        if self.visits_count ||= 0        
        end
    end
end
