require_relative 'entry'
require "csv"

class AddressBook
    attr_reader :entries
    
    def initialize()
        @entries = []
    end
    
    def add_entry(name, phone_number, email)
        index = 0
        entries.each do |entry|
            if name < entry.name
                break
            end
            index+= 1
        end
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
    
    def import_from_csv(file_name)
        # Implementation goes here
        csv_text = File.read(file_name)
        csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
        
        csv.each do |row|
            row_hash= row.to_hash
            add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
            puts row_hash["name"]
        end
    end
 
    # Search AddressBook for a specific entry by name
    def binary_search(name)
        # #1
        lower = 0
        upper = entries.length - 1
 
        # #2
        while lower <= upper
            # #3
            mid = (lower + upper) / 2
            mid_name = entries[mid].name
 
            # #4
            if name == mid_name
                return entries[mid]
            elsif name < mid_name
                upper = mid - 1
            elsif name > mid_name
                lower = mid + 1
            end
        end
 
     # #5
     return nil
   end
   
end

#a = AddressBook.new
#a.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
#a.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

#a.import_from_csv("/home/ubuntu/workspace/address_bloc/entries.csv")
