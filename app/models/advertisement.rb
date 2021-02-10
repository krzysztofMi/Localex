class Advertisement < ApplicationRecord
    self.inheritance_column = nil
    belongs_to :user
    enum type: {
        free: "free",
        exchange: "exchange",
        pay: "pay"
    }
    validates :name, :presence => true
    validates :type, :presence => true
    validates :place, :presence => true
end
