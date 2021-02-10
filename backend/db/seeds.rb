
roles = [
    {type: "ADMIN"},
    {type: "USER"},
    {type: "MODERATOR"}    
]

roles.each do |role|
    Role.create(role) unless Role.where(role).first
end

users = [
    {email: 'krzysztof@email.pl', nickname: 'krzysztof', phone: 1234567, password_digest: '123'},
    {email: 'wojtek@email.pl', nickname: 'wojtek', phone: 1234567, password_digest: '321'}
]

users.each do |user|
    User.create(user) unless User.where(user).first
end
