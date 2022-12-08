require "open-uri"
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
puts "Wiping away categories"
Category.delete_all

puts "_______________________"

puts "Baking up two users with the role 'homeowner'"
homeowner_array = []
2.times do |i|
  prof_pic = URI.open(Faker::LoremFlickr.image(size: "200x200", search_terms: ['face']))
  homeowner = User.new({
                         first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         location: Faker::Address.full_address,
                         role: "homeowner",
                         email: "#{i + 1}@homeowner.com",
                         password: "123456"
                       })
  homeowner.photo.attach(io: prof_pic, filename: "homeowner#{i}.jpeg", content_type: "image/jpeg")
  homeowner.save!
  homeowner_array << homeowner
  puts "+++ #{homeowner.first_name} #{homeowner.last_name}"
end

puts "_______________________"

caretaker_array = []
puts "Grilling a few users with the role 'caretaker'"
6.times do |i|
  prof_pic = URI.open(Faker::LoremFlickr.image(size: "200x200", search_terms: ['face']))
  caretaker = User.create({
                            first_name: Faker::Name.first_name,
                            last_name: Faker::Name.last_name,
                            location: Faker::Address.full_address,
                            role: "caretaker",
                            email: "#{i + 1}@caretaker.com",
                            password: "123456"
                          })
  caretaker_array << caretaker
  caretaker.photo.attach(io: prof_pic, filename: "caretaker#{i}.jpeg", content_type: "image/jpeg")
  caretaker.save
  puts "+++ #{caretaker.first_name} #{caretaker.last_name}"
end

puts "_______________________"

puts "Stewing up some hot new trips!"

def_trips = [
  ["Paris Anniversary trip", "Anniversary of good old Aunt Berta. Will arrive at noon.", "https://images.unsplash.com/photo-1507666664345-c49223375e33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2074&q=80"],
  ["Milwaukee Work trip", "Business trip. Meeting in Milwaukee to track the progress of all offshore projects.", "https://images.unsplash.com/photo-1572854385804-33937a570b24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2531&q=80"],
  ["Madness in Madrid", "Bachellor's party of an old friend. Going to be lit!", "https://images.unsplash.com/photo-1539037116277-4db20889f2d4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"],
  ["Climbing Mount Kilimanjaro", "Climbing trip with some adventure buddies. Will be offline for the most of the journey.", "https://images.unsplash.com/photo-1516616370751-86d6bd8b0651?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3840&q=80"],
  ["Bridesmaid Bonanza", "Family trip to spend some time away from everyday madness.", "https://images.unsplash.com/photo-1550005800-602985c66ed7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"],
  ["Safari in Ghana", "Sightseeing in Africa. Rivers, mountains, beasts, got to see them all!", "https://images.unsplash.com/photo-1516426122078-c23e76319801?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2068&q=80"]
]

trip_array = []
6.times do |i|
  trip_pic = URI.open(def_trips[i][2].to_s)
  trip = Trip.new({
                    name: def_trips[i][0].to_s,
                    description: def_trips[i][1].to_s,
                    start_date: Date.parse("2023-01-#{rand(24..27)}"),
                    end_date: Date.parse("2023-02-#{rand(1..5)}"),
                    location: Faker::Address.full_address,
                    entry_type: ["Lockbox", "Digital Lock", "Hidden Key", "Other"].sample
                  })
  trip.user = homeowner_array.sample
  trip.photo.attach(io: trip_pic, filename: "trip#{i}.jpeg", content_type: "image/jpeg")
  trip.save!
  trip_array << trip
  puts "+++ #{trip.name}"
end

puts "_______________________"

puts "Serving up some steamy categories!"

categories_array = ["Mail", "Plants", "General", "Security", "Animals", "Maintenance"]

categories_array.each do |e|
  puts e
  Category.create({ name: e })
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
  ["Feed Gerbil", "Fill up food bowl and change water.", "Animals"],
  ["Sing to the plants", "Sing beautifuly to the plants in the basement. They are lonely and cold.", "Plants"],
  ["Water the cactus", "Water the cactus. The cactus is thirsty. The cactus needs water. Cactus.", "Plants"],
  ["Check the food in the fridge", "Look for expired food inside, and remove it if there's any", "Maintenance"],
  ["Scrub the floorboards", "Please scrub the floorboards, so they look like new.", "Maintenance"],
  ["Wipe all the bulbs", "Dust of all of the light bulbs, so they don't look as dim.", "Maintenance"],
  ["Clean the driveway", "Clean the driveway, and remove any leaves laying around, so the house looks more maintained", "Maintenance"]
]

50.times do
  current_task = tasks_array.sample
  task = Task.new({
                    name: current_task[0],
                    description: current_task[1]
                  })
  task.trip = trip_array.sample
  task.user = caretaker_array.sample
  trip_dates = ((Date.new(task.trip.start_date.year, task.trip.start_date.month, task.trip.start_date.day))..(Date.new(task.trip.end_date.year, task.trip.end_date.month, task.trip.end_date.day))).to_a
  task.date = trip_dates.sample
  task.category = Category.find_by({ name: current_task[2] })
  task.save
  puts "+++ #{task.name}"
end
