# #1
require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    
    def initialize()
        @address_book = AddressBook.new
    end
    
    def main_menu
         # #2
         puts "Main Menu - #{address_book.entries.count} entries"
         puts "1 - View all entries"
         puts "2 - View Entry Number n"
         puts "3 - Create an entry"
         puts "4 - Search for an entry"
         puts "5 - Import entries from a CSV"
         puts "6 - Clear all entries from the database"
         puts "7 - Exit"
         print "Enter your selection: "
         
         # #3
         selection = gets.to_i
         
         # #7
        case selection
            when 1
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                view_entry_n
                main_menu
            when 3
                system "clear"
                create_entry
                main_menu
            when 4
                system "clear"
                search_entries
                main_menu              
            when 5
                system "clear"
                read_csv
                main_menu
            when 6
                system "clear"
                nuke_entries
                main_menu
            when 7
                puts "Good-bye!"
                # #8
                exit(0)
            # #9
        else 
            system "clear"
            puts "Sorry, that is not a valid input"
            main_menu
        end
    end
    
    # #10
    def view_all_entries
        # #14
        address_book.entries.each do | entry |
            system "clear"
            puts entry.to_s
            # #15
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end
    
    def view_entry_n
        system "clear"
        print "Entry number: "
        entry_index = gets.to_i
        if entry_index >= 1 && entry_index <= address_book.entries.length
            entry = address_book.entries[entry_index - 1]
            puts entry.to_s
        end
    end
    
    def create_entry
        # #11
        system "clear"
        puts "New AddressBloc Entry"
        # #12
        print "Name: "
        name = gets.chomp
        print "Phone number: "
        phone = gets.chomp
        print "6Email: "
        email = gets.chomp
        
        # #13
        address_book.add_entry(name, phone, email)
        
        system "clear"
        puts "New entry created"
        
    end
    
    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
    end
    
    def nuke_entries
        puts "Warning: all entries in database will be deleted. Proceed? Yes/No"
        proceed_yn = gets.chomp
        
        case proceed_yn.downcase
            when "yes"
                address_book.nuke_entries
                system "clear"
                puts "Database has been emptied"
            when "no"
                system "clear"
                main_menu
        else
                system "clear"
                puts "Please answer yes or no"
                nuke_entries
        end
    end
    
    def edit_entry(entry)
        # #4
        print "Updated name: "
        name = gets.chomp
        print "Updated phone number: "
        phone_number = gets.chomp
        print "Updated email: "
        email = gets.chomp
        # #5
        entry.name = name if !name.empty?
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"
        # #6
        puts "Updated entry:"
        puts entry
    end
    
    def search_entries
        # #9
        print "Search by name: "
        name = gets.chomp
        # #10
        match = address_book.binary_searh(name)
        system "clear"
        # #11
        if match
            puts match.to_s
            search_submenu(match)
        else
            puts "No match found for #{name}"
        end
    end
    
    def search_submenu(entry)
        # #12
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to maine menu"
        # #13
        selection = gets.chomp
        
        # #14
        case selection
            when "d"
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                edit_entry(entry)
                system "clear"
                main_menu
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                puts entry.to_s
                search_submenu(entry)
        end
    end
    
    def read_csv
        # #1
        print "Enter CSV to import: "
        file_name = gets.chomp
        
        # #2
        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end
        
        # #3
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
            puts "#{file_name} os not a valid CSV file, please enter the name of a valid CSV file"
            read_csv
        end
    end
    
    def entry_submenu(entry)
        # #16
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        
        # #17
        selection = gets.chomp
        case selection
            when "n"
            when "d"
            # #7
                delete_entry(entry)
            when "e"
            # #8
                edit_entry(entry)
                entry_submenu(entry)
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                entry_submenu(entry)
        end        
    end
end