roles = [
    {type: "ADMIN"},
    {type: "USER"},
    {type: "MODERATOR"}    
]
pRoles = []
roles.each do |role|
    pRoles.push(Role.create(role)) unless Role.where(role).first
end

users = [
    {email: 'krzysztof@email.pl', nickname: 'krzysztof', password_digest: User.digest('1234567'), role: pRoles[0]},
    {email: 'wojtek@email.pl', nickname: 'wojtek', password_digest: User.digest('6543210'), role: pRoles[1]}
]

users.each do |user|
    User.create!(user) unless User.where(user).first
end
