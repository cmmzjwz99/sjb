task :check_blacklist => :environment do

  users = ['13676591859', '13682908544', '15826970990']
  users.each do |user|
    u = User.find_by_phone(user)
    if u
      PreCheckTask.perform_async(u.id)
    end
  end
end