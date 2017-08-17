def input_students
  puts "Please enter the names of the students and their cohort"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  #name = gets.split_by(" ")[0],cohort = gets.strip
  #cohort = gets.chomp
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
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
  puts "-------------"
end

def student_selector(students)
    students.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)" if student[:name][0].capitalize == "N" && student[:name].length < 12
    end
end


def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end


students = input_students
#nothing happens until we call the methods
print_header
student_selector(students)
#print (students.map {print e if |e| e.start_with?('b')}}
print_footer(students)

#students.map.{|student| student[:cohort] == cohort}
