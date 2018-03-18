# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

unless CropUser.find_by(id: 1)
  company = Company.create(name: 'healo')
  company.crop_users.create(account: 'haelo', password: 'haelo')
end