  @students = [] # an empty array accessible to all methods

  def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
  end


  def interactive_menu
    loop do
      print_menu
      process(gets.chomp)
    end
  end


def process(selection)
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
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def push_to_students(name, cohort, height, eyecolour)
  @students << {name: name, cohort: cohort, height: height, eyecolour: eyecolour}
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = gets.strip                                 # get the first name
  while !name.empty? do                             # while the name is not empty, repeat this code
    puts "Which cohort have they been placed on?"
    cohort = gets.strip.to_sym
    if cohort.empty?
      cohort = "Not yet placed in a"
    end
    puts "Height?"
    height = gets.strip
    puts "Eye colour?"
    eyecolour = gets.strip

    # add the student hash to the array
    @students << {name: name, cohort: cohort, height: height, eyecolour: eyecolour}
    puts "Now we have #{@students.count} students"
    puts "Please enter the details of more students"
    # get another name from the user
    name = gets.strip
  end
end


def show_students
  print_header
  student_selector
  print_footer
end


def print_header
  center_me("The students of Villains Academy")
  center_me("------------")
end


def student_selector
  @students.each_with_index do |student, index|
   puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)" if student[:name][0].capitalize == "J" && student[:name].length < 12
  end
end


#centering method for strings
def center_me(string)
  puts string.center(50)
end

#footer to print singular or plural students
def print_footer
  if @students.count == 1
    puts "Overall, we have a great student".center(50)
  else
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end


def none_enrolled(students)
  if students.count >= 1
    print_header
    print_footer(students)
    print(students)
  else
    puts "Oops...there appears to be no students enrolled yet."
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

interactive_menu
students = input_students
none_enrolled(students)
