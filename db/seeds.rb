# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

company = Company.find_by_name 'haelo'
company = Company.create name: 'haelo' unless company

if CropUser.count == 0
  company.crop_users.create account: 'haelo', password: 'haelo', phone: '18351882074'
  company.public_accounts.create(name: 'test',
                                 account: 'gh_b3fe701588df',
                                 appid: 'wx992037f0a32db788',
                                 appsecret: 'ebf11ea81d4887f9fd26987241262913')
end