require 'csv'                                             # to access the CSV library


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
      exit                                                # this will cause the program to terminate
    else
      puts "I don't know what you mean, try again"
  end
end


#appending the user input to the students array
def push_to_students(name, cohort, height, eyecolour)
  @students << {name: name, cohort: cohort, height: height, eyecolour: eyecolour}
end


def input_students
    option_selected
  puts "Please enter the name of the student (to finish, just hit return twice)"
  name = STDIN.gets.strip
                               # get the first name
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


def show_students
  option_selected
  print_header
  student_selector
  print_footer
end


def student_selector
  @students.each_with_index do |student, i|
  #  if student[:name][0].capitalize == "J" && student[:name].length < 12
      puts ("#{i+1}. #{@students[i][:name]}, #{@students[i][:cohort]} cohort, #{@students[i][:height]}, #{@students[i][:eyecolour]}")
  end
end


def print_header
  center_me("The students of Villains Academy")
  center_me("------------")
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
#CSV writing notation
CSV.open("students.csv", "w") do |student|
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:height], student[:eyecolour]]
      csv_line = student_data.join(",")
      file.puts(csv_line)
    end
  option_selected
end
end


#using code block to avoid having to close file explictly
def load_students(filename = "students.csv")
  puts "Select a file you would like to use."            #Prompting user for file to be loaded
  @filename = STDIN.gets.chomp                           #@file variable created to make it accessible to all methods
  @filename = File.open(@filename, "r")
    @filename.readlines.each do |line|
        if line
          name, cohort, height, eyecolour = line.chomp.split(',')
          push_to_students(name, cohort, height, eyecolour)
          #@students << {name: name, cohort: cohort.to_sym, height: height, eyecolour: eyecolour}
        end
      end
  option_selected
end


#using code block to avoid having to close file explictly
#@file variable created to make it accessible by all methods
def try_load_students
  @filename = ARGV.first # first argument from the command line
  if @filename.nil? # get out of the method if it isn't given
    load_students
  elsif File.exists?(@filename) #if it exists
    load_students(@filename)
     puts "Loaded #{@students.count} from #{@filename}"
  else # if it doesn't exist
    puts "Sorry, #{@filename} doesn't exist."
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
