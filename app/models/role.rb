class Role < ApplicationRecord
    has_many :users
    self.inheritance_column = nil
    enum type: {
        admin: "ADMIN",
        user: "USER",
        moderator: "MODERATOR"
    }
end
