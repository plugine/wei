# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User::AdminUser.find_by(id: 1)
  User::AdminUser.create(account: 'yeehandsome', password: 'P@ss!Com,Net25-CN30!##')
end