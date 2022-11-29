# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning up tasks..."
Task.delete_all
puts "Sweeping away trips..."
Trip.delete_all
puts "Mopping up users"
User.delete_all

puts "_______________________"

puts "Baking up two users with the role 'homeowner'"
homeowner_array = []
2.times do |i|
  homeowner = User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: Faker::Address.full_address,
    role: "homeowner",
    email: "#{i}@homeowner.com",
    password: "123456"
  })
  homeowner_array << homeowner
  puts "+++ #{homeowner.first_name} #{homeowner.last_name}"
end

puts "_______________________"

caretaker_array = []
puts "Grilling a few users with the role 'caretaker'"
6.times do |i|
  caretaker = User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: Faker::Address.full_address,
    role: "caretaker",
    email: "#{i}@caretaker.com",
    password: "123456"
  })
  caretaker_array << caretaker
  puts "+++ #{caretaker.first_name} #{caretaker.last_name}"
end

puts "_______________________"

puts "Stewing up some hot new trips!"

trip_array = []
5.times do
  city = Faker::Address.city
  trip = Trip.new({
    name: "#{city} #{Faker::Verb.ing_form} trip",
    description: Faker::Lorem.sentences(number: 3).join(" "),
    start_date: "2023-01-#{(10..27)}",
    end_date: "2023-02-#{(10..27)}"
  })
  trip.user = homeowner_array.sample
  trip.save
  trip_array << trip
  puts "+++ #{trip.name}"
end

puts "_______________________"

puts "Serving up some steamy categories!"

categories_array = ["Mail", "Plants", "General", "Security", "Animals", "Maintenance"]

categories_array.each do |e|
  puts e
  Category.create({name: e})
end


puts "_______________________"

puts "Toasting some sweet & indulgent tasks!"
tasks_array = [
  ["Bring in Mail", "Bring in the mail, remove any doorknob ads, or any mail or packages that have been left at the front door.", "Mail"],
  ["Water Plants", "Please fill up the watering can near the sink and water the various and sundry house plants. The monsterra needs to drraaaaannnkkkk!!", "Plants"],
  ["Check on Car", "Start cars and run them for 15 minutes to charge battery if needed.", "General"],
  ["Anti-Burglar Activities", "Any activities that will make the house look occupied, such as tramping around after new snow, and driving the cars in and out of the driveway or changing their positions in the parking lot.", "Security"],
  ["Check on Pool", "Check pool chemical levels and add accordingly.", "Maintenance"],
  ["A/C Off", "Ensure that the thermostat is set to 'off.'", "General"],
  ["General Inspection", "Inspect the house for damage or signs of intruders.", "General"],
  ["Remove Insects", "Remove spiderwebs and spray insect repellant near motion detectors.", "General"],
  ["Check Security Measures", "Check security lights and lights on timers and and replace light bulbs that have burnt out.", "Security"],
  ["Remove Trash", "Ensure that trash is taken to the curb. Trash days are Wedensday and Friday.", "General"],
  ["Feed Goldfish", "Use two pinches of ExtraGold3000 fish food.", "Animals"],
  ["Wind Grandfather Clock", "Please be careful, this is a precious family heirloom.", "Maintenance"],
  ["Check Ceiling for Leaks", "Roof has been leaking for awhile, please check for new wet spots.", "General"],
  ["Look for Important Package", "Expecting important documents in the mail - please look for Fedex box.", "Mail"],
  ["Check Cat", "Ensure that Suzie has not brought in another rat", "Animals"],
  ["Check Smoke Detectors", "Ensure they have enough battery", "Maintenance"],
  ["Ensure the Outside Gate is Locked", "Use the padlock to lock the outside gate.", "Security"],
  ["Lock the Side Door", "Please make sure the side door in the kitchen is locked.", "Security"],
  ["Feed the Cat", "One Fancy Feast for Matilda, refill dry food.", "Animals"],
  ["Ensure Windows are Closed", "No drafts, please!", "Security"],
  ["Feed Gerbil", "Fill up food bowl and change water.", "Animals"]
]

20.times do |i|
  tasks = tasks_array[i - 1]
  task = Task.new({
    name: tasks[0],
    description: tasks[1],
  })
  task.user = caretaker_array.sample
  task.trip = trip_array.sample
  task.category = Category.find_by({name: tasks[2]})
  task.save
  puts "+++ #{task.name}"
end
