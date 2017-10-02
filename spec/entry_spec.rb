require_relative '../models/entry'
# #1
RSpec.describe Entry do
    # #2
    describe "attributes" do
        let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')}
        # #3
        it "reports its name" do
            # #4
            expect(entry.name).to eq('Ada Lovelace')
        end
        
        it "reports its phone number" do
            expect(entry.phone_number).to eq('010.012.1815')
        end
        
        it "reports it email" do
            expect(entry.email).to eq('augusta.king@lovelace.com')
        end
    end
    
    # #5
    describe "#to_s" do
        it "prints an entry as a string" do
            entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
            expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
            # #5
            expect(entry.to_s).to eq(expected_string)
        end
    end
end