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

UserArea.create(user:User.find_by_login('admin'),zjwz:true,zjsxsz:true,zjsxkq:true,zjsxyc:true,zjhz:true,ahhf:true)

UserPower.create(user:User.find_by_login('admin'),input:true,first_verify:true,online_verify:true,customer_verify:true,
                 car_verify:true,user_manage:true,financial:true)


