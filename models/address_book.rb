require_relative 'entry'
require "csv"

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
    
    # #7
    def import_from_csv(file_name)
        # Implementation goes here
        csv_text = File.read(file_name)
        csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
        
        # #8
        csv.each do |row|
            row_hash= row.to_hash
            add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
            puts row_hash["name"]
        end
    end
   
end

#a = AddressBook.new
#a.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
#a.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

#a.import_from_csv("/home/ubuntu/workspace/address_bloc/entries.csv")
