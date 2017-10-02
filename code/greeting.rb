def greeting
    ARGV.each do | arg |
        puts "Hey #{arg}"
    end
end

greeting