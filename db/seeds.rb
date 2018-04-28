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

User.create(login: 'admin',  password: '123456',verify_password:'123456',profile_id:1,identity:1)
User.create(login: 'yzdzs',  password: '123456',verify_password:'123456',profile_id:1,identity:2)
User.create(login: 'caiwu',  password: '123456',verify_password:'123456',profile_id:1,identity:6)
