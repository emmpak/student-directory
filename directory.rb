@students = [] # an empty array accessible to all methods
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  puts "You have successfully selected option #{selection}."
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit enter twice"
  get_and_add_student
end

def get_and_add_student
  while true do
    name = STDIN.gets.chomp
    break if name.empty?
    add_student(name)
    puts "Now we have #{@students.count} students"
  end
end

def add_student(name, cohort = :november)
  @students << {name: name, cohort: cohort}
end

def print_header
  puts "The students of Villains Academy"
  puts "______________"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  puts "What file would you like to save the students to?"
  filename = STDIN.gets.chomp
  # open the file for writing
  File.open(filename, 'w') { |f| saving_to(f)}
end

def saving_to(file)
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
end

def load_students(filename = "")
  if filename.empty?
    puts "Please enter the name of the file where the student data is stored:"
    filename = STDIN.gets.chomp
  end
  File.open(filename, 'r') { |f| loading_from(f)}
end

def loading_from(file)
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort.to_sym)
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu
