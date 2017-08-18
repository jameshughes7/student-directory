def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []                                     # create an empty array
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
    students << {name: name, cohort: cohort, height: height, eyecolour: eyecolour}
    puts "Now we have #{students.count} students"
    puts "Please enter the details of more students"
    # get another name from the user
    name = gets.strip
  end
  # return the array of students
  students
end

def print_header
  center_me("The students of Villains Academy")
  center_me("------------")
end


def student_selector(students)
  students.each_with_index do |student, index|
   puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)" if student[:name][0].capitalize == "J" && student[:name].length < 12
  end
end


#centering method for strings
def center_me(string)
  puts string.center(50)
end

#footer to print singular or plural students
def print_footer(names)
  unless names.count == 1
    puts "Overall, we have #{names.count} great students.".center(50)
  else
    puts "Overall, we have #{names.count} great student.".center(50)
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

students = input_students
none_enrolled(students)
