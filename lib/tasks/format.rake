task :format_contacts => :environment do

  cnt = 0
  update = 0

  UserContact.find_in_batches do |group|
    begin
      UserContact.transaction do
        group.each do |contact|
          phone = MobileUtils.format_phone(contact.phone)
          if phone != contact.phone
            contact.phone = phone
            contact.save
            update += 1
          end
          cnt += 1
        end
      end
    rescue Exception => e
      puts e.message
    end
  end

  puts "total #{cnt} records processed"
  puts "total #{update} records updated"
end