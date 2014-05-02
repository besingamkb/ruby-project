# file = File.new('test1.txt', 'a')


# file.puts "mark kevin besinga"
# file.close

names = []

file = File.open('test1.txt', 'r')do |file|

	while line = file.gets
		names << line.chomp.capitalize
	end
end
test = []
names.each do |name|
	test << name.split(" ")
end

puts test