# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)




user = User.new(email: 'user@user.com', password: 'user123', role: :user)
user.save
puts 'User criado com sucesso!'


admin = User.new(email: 'admin@admin.com', password: 'admin123', role: :admin)
admin.save
puts 'Admin criado com sucesso!'

puts user.user?  # true
puts admin.admin? # true

puts 'Usuários criados com sucesso!'

