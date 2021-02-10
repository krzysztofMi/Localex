roles = [
    {type: "ADMIN"},
    {type: "USER"},
    {type: "MODERATOR"}    
]

roles.each do |role|
    Role.create(role) unless Role.where(role).first
end

users = [
    {email: 'krzysztof@email.pl', nickname: 'krzysztof', password_digest: User.digest('1234567'), roles_id: 1},
    {email: 'wojtek@email.pl', nickname: 'wojtek', password_digest: User.digest('6543210'), roles_id: 2}
]

users.each do |user|
    User.create!(user) unless User.where(user).first
end
