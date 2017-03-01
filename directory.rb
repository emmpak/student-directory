def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit enter twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "______________"
end

def print(students)
  count = 0
  while count < students.length
    puts "#{students[count][:name]} (#{students[count][:cohort]} cohort)"
    count += 1
  end
end

def print_students_with_letter(students)
  puts "What letter does the name of the student start with?"
  letter = gets.chomp.capitalize
  puts "Here are the students starting with '#{letter}':"
  # using the filtered array as an argument for the print function
  print(students.select { |student| student[:name].start_with? letter})
end

def print_students_upto_n_characters(students, n)
  print(students.select { |student| student[:name].length < 12})
end

def add_categories(students)
  puts "What additional information would you like to enter for each student?"
  # create an empty array to store the categories entered by user
  categories = []
  # get the first catergory and keep adding values to the array until user hits enter twice
  while true
    category = gets.chomp
    break if category.empty?
    categories << category
  end
  # iterate over each student
  students.each do |student|
    puts "Name: #{student[:name]}"
    #iterate over the categories and ask the user for input
    categories.each do |category|
      puts category
      input = gets.chomp
      # add the category to the hash
      student[category] = input if !input.empty?
    end
  end
  puts students
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
# nothing happens until we call the methods
 print_header
 print(students)
 print_footer(students)
# print_students_with_letter(students)
# print_students_upto_n_characters(students, 12)
 add_categories(students)
