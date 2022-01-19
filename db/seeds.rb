Item.destroy_all
require 'faker'

puts "Creating random items..."
10.times do
    Item.create(name: [Faker::Appliance.equipment, Faker::ElectricalComponents.electromechanical, Faker::Device.model_name].sample, brand: Faker::Appliance.brand, count: rand(1..200), tag: ["Domestic", "International"].sample,  category: ["Clothing", "Food and Drinks", "Books", "Entertainment", "Electronic Devices", "Health and Personal Care", "Office Products", "Sports", "Tools and Home Improvements", "Fine Art", "Other"].sample, weight: rand(1..2000), produced_by: [Faker::Company.name, Faker::Device.manufacturer].sample, produced_in: Faker::Address.country)
end
puts "Successfully finished creating items!"
