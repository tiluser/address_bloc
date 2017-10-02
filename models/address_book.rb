# #8
require_relative 'entry'

class AddressBook
    attr_reader :entries
    
    def initialize()
        @entries = []
    end
    
    def add_entry(name, phone_number, email)
     # #9
        index = 0
        entries.each do |entry|
         # #10
            if name < entry.name
                break
            end
            index+= 1
        end
        # #11
        entries.insert(index, Entry.new(name, phone_number, email))
    end
 
    def remove_entry(name, phone_number, email)
        indexes_to_delete = []
        entries.each_with_index do |entry, index|
            if entry.name == name && entry.phone_number == phone_number && entry.email == email
               indexes_to_delete.push(index)
            end
        end

        indexes_to_delete.each do |index|
            entries.delete_at(index)
        end
        # puts entries.size
    end  
   
end

a = AddressBook.new
a.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
a.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')