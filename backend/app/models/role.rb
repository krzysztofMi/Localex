class Role < ApplicationRecord
    self.inheritance_column = nil
    enum type: {
        admin: "ADMIN",
        user: "USER",
        moderator: "MODERATOR"
    }
end
