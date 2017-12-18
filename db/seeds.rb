# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'digest/sha1'




admin = Profile.create(label: 'admin', nicename: 'Publify administrator',
                       modules: [:dashboard, :profile])
publisher = Profile.create(label: 'publisher', nicename: 'Blog publisher',
                           modules: [:dashboard, :profile])
contributor = Profile.create(label: 'contributor', nicename: 'Contributor',
                             modules: [:dashboard, :profile ])

User.create(login: 'admin', email: '948993066@qq.com', password: 'lhd2016',verify_password:'lhd2016',level:0,score:0)
User.create(login: 'test01', email: '948993066@qq.com', password: '123456',verify_password:'123456',phone:'18868945291',level:0,score:0)
