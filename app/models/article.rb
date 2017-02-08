class Article < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :body, presence: true
    validates_length_of :body, minimum: 5
    validates_uniqueness_of :title
    before_save :set_visits_count
    
    def update_visits_count
        self.save if self.visits_count.nil?
        self.update(visits_count: self.visits_count + 1)  
        puts "+++++++++++++++++"
        puts self.errors.inspect
        puts "++++++++++++++++++"
    end
    private  
    
    def set_visits_count
        self.visits_count ||= 0
    end
end
