@students = []                                            # an empty array accessible to all methods

  def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit"                                        # 9 because we'll be adding more items
  end


  def interactive_menu
    loop do
      print_menu
      process(STDIN.gets.chomp)
    end                                                   #
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
      exit                                                # this will cause the program to terminate
    else
      puts "I don't know what you mean, try again"
  end
end


def input_students
    option_selected
  puts "Please enter the name of the student (to finish, just hit return twice)"

  name = STDIN.gets.strip                                 # get the first name
  while !name.empty? do                                   # while the name is not empty, repeat this code
    puts "Which cohort have they been placed on?"
    cohort = STDIN.gets.strip.to_sym
    if cohort.empty?
      cohort = "Not yet placed in a"
    end
    puts "Height?"
    height = STDIN.gets.strip
    puts "Eye colour?"
    eyecolour = STDIN.gets.strip
    push_to_students(name, cohort, height, eyecolour)

    puts "Now we have #{@students.count} students"
    puts "Please enter the details of more students"
    # get another name from the user
    name = STDIN.gets.strip
  end
end

#appending the user input to the students array
def push_to_students(name, cohort, height, eyecolour)
  @students << {name: name, cohort: cohort, height: height, eyecolour: eyecolour}
end


def show_students
  option_selected
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
    if student[:name][0].capitalize == "J" && student[:name].length < 12
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end


#footer to print singular or plural students
def print_footer
  if @students.count == 1
    puts "Overall, we have a great student".center(50)
  else
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end


#using code block to avoid having to close file explictly
def save_students
  # open the file for writing
  File.open("students.csv", "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts(csv_line)
    end
  end
  option_selected
end


#using code block to avoid having to close file explictly
def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
        if line
          name, cohort = line.chomp.split(',')
          @students << {name: name, cohort: cohort.to_sym}
        end
      end
    end
  option_selected
end


def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # get out of the method if it isn't given
    load_students
  elsif File.exists?(filename) #if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end


#centering method for strings
def center_me(string)
  puts string.center(50)
end

#feedback message when user chooses option from the interactive menu
def option_selected
  puts "Your option has been selected successfully!"
end


try_load_students
interactive_menu
