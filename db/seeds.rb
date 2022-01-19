Item.destroy_all
require 'faker'

puts "Creating random items..."
30.times do
    Item.create(name: [Faker::Appliance.equipment, Faker::ElectricalComponents.electromechanical, Faker::Device.model_name].sample, brand: Faker::Appliance.brand, count: rand(1..200), tag: ["Domestic", "International"].sample,  category: ["Clothing", "Food", "Drinks", "Books", "Entertainment", "Electronics", "Health", "Personal Care", "Office", "Sports", "Tools", "Art", "Other"].sample, weight: rand(1..2000), produced_by: [Faker::Company.name, Faker::Device.manufacturer].sample, produced_in: ["China", "India", "Germany", "United States", "Japan", "Ethiopia", "Nigeria", "South Korea", "Indonesia", "France", "Italy", "United Kingdom"].sample)
end
puts "Successfully finished creating items!"
