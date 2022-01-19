require_relative '../config/environment'
require 'tty-prompt'

class InventoryApp
  # it is not an AR class so you need to add attr
  attr_accessor :prompt, :items

  def initialize
    @prompt = TTY::Prompt.new
  end

  def title_print
    font = TTY::Font.new(:doom)
    puts font.write("INVENTORY   APP", letter_spacing: 4)
  end

  def greeting
    self.title_print
    puts "Welcome to INVENTORY APP! A new innovative way to manage your items. For any logistics company!!"
  end

  def main_menu
    answer = self.prompt.select("Main Menu") do |menu|
        menu.choice "View Summary", -> {self.summary}
        menu.choice "View All Items", -> {self.all_items_display}
        menu.choice "Add an Item", -> {self.create_item}
        menu.choice "Edit Items", -> {self.edit_item}
        menu.choice "Delete an Item", -> {self.delete_item}
        menu.choice "Filter Items", -> {self.filter_items}
        menu.choice "Exit", -> {exit}
    end
  end

  def summary
    puts "Total Number of Items: #{Item.count}"
    puts "Total Count of Items: #{Item.total_count}"

    puts "Total Number of International Items: #{Item.tag_total_number("International")}"
    puts "Total Count of International Items: #{Item.tag_total_count("International")}"

    puts "Total Number of Domestic Items: #{Item.tag_total_number("Domestic")}"
    puts "Total Count of Domestic Items: #{Item.tag_total_count("Domestic")}"

    puts "----------##########---------"

    puts "Count Summaries based on Categories: "
    puts "-- Clothing: #{Item.category_count("Clothing")}"
    puts "-- Food: #{Item.category_count("Food")}"
    puts "-- Drinks: #{Item.category_count("Drinks")}"
    puts "-- Books: #{Item.category_count("Books")}"
    puts "-- Entertainment: #{Item.category_count("Entertainment")}"
    puts "-- Health: #{Item.category_count("Health")}"
    puts "-- Personal Care: #{Item.category_count("Personal Care")}"
    puts "-- Office: #{Item.category_count("Office")}"
    puts "-- Sports: #{Item.category_count("Sports")}"
    puts "-- Tools: #{Item.category_count("Tools")}"
    puts "-- Art: #{Item.category_count("Art")}"
    puts "-- Other: #{Item.category_count("Other")}"

    puts "----------##########---------"

    puts "Summary based on Producing Countries: "
    puts "-- Ethiopia: #{Item.produced_in_count("Ethiopia")}"
    puts "-- China: #{Item.produced_in_count("China")}"
    puts "-- India: #{Item.produced_in_count("India")}"
    puts "-- Germany: #{Item.produced_in_count("Germany")}"
    puts "-- United States: #{Item.produced_in_count("United States")}"
    puts "-- Japan: #{Item.produced_in_count("Japan")}"
    puts "-- Nigeria: #{Item.produced_in_count("Nigeria")}"
    puts "-- South Korea: #{Item.produced_in_count("South Korea")}"
    puts "-- Indonesia: #{Item.produced_in_count("Indonesia")}"
    puts "-- France: #{Item.produced_in_count("France")}"
    puts "-- Italy: #{Item.produced_in_count("Italy")}"
    puts "-- United Kingdom: #{Item.produced_in_count("United Kingdom")}"

    self.main_menu
  end

  def create_item
    result = self.prompt.collect do
      key(:name).ask("Name: ", required: true)
      key(:brand).ask("Brand: ", required: true)
      key(:count).ask("Count: ", required: true)
      key(:tag).ask("Tag: ", required: true)
      key(:category).ask("Category: ", required: true)
      key(:weight).ask("Weight (Enter a valid numeric value - i.e. > 0): ", convert: :float, required: true)
      key(:produced_by).ask("Produced By: ", required: true)
      key(:produced_in).ask("Produced In: ", required: true)
    end

    if Item.create(result)
      self.success_interface("Successfully created a new item!")
    end

    self.all_items_display
    
  end

  def delete_item
    answer = self.prompt.select("Pick an item to delete") do |menu|
        Item.all.map{
            |item|
            menu.choice item.name, -> {Item.destroy(item.id)}
        }
            menu.choice "Cancel", -> {self.main_menu}
    end

    self.success_interface("Successfully deleted item!")
    self.main_menu
  end

  def all_items_display

    table = TTY::Table.new(header: ["Name", "Brand", "Count", "Tag", "Category", "Weight", "Produced By", "Produced In"]) do |t|
      Item.all.each{ |item|
          items_array = Array.new

          items_array << item.name
          items_array << item.brand
          items_array << item.count
          items_array << item.tag
          items_array << item.category
          items_array << item.weight
          items_array << item.produced_by
          items_array << item.produced_in

          t << items_array
      }
    end
    
    puts table.render(:ascii)

    self.main_menu
  end

  def edit_item
    answer = self.prompt.select("Pick an item to edit") do |menu|
      Item.all.map{
          |item|
          menu.choice item.name, -> {self.edit_interface(item.id)}
      }
          menu.choice "Cancel", -> {self.main_menu}
    end
  end

  def edit_interface(item_id)
    selected_items = Item.all.select{
      |item| item.id == item_id
    }

    selected_item = selected_items[0]

    puts "----------------------------------"

    puts "Name: #{selected_item.name}"
    puts "Brand: #{selected_item.brand}"
    puts "Count: #{selected_item.count}"
    puts "Tag: #{selected_item.tag}"
    puts "Category: #{selected_item.category}"
    puts "Weight: #{selected_item.weight}"
    puts "Produced by: #{selected_item.produced_by}"
    puts "Produced in: #{selected_item.produced_in}"

    puts "----------------------------------"

    puts " "

    answer = self.prompt.select("Select the field you would like to edit") do |menu|
      menu.choice "Name", -> {self.edit_input(selected_item, "Name")}
      menu.choice "Brand", -> {self.edit_input(selected_item, "Brand")}
      menu.choice "Count", -> {self.edit_input(selected_item, "Count")}
      menu.choice "Tag", -> {self.edit_input_choice(selected_item, "Tag")}
      menu.choice "Category", -> {self.edit_input_choice(selected_item, "Category")}
      menu.choice "Weight", -> {self.edit_input(selected_item, "Weight")}
      menu.choice "Produced by", -> {self.edit_input(selected_item, "Produced By")}
      menu.choice "Produced in", -> {self.edit_input(selected_item, "Produced In")}
      menu.choice "Cancel", -> {self.main_menu}
    end

  end

  def edit_input(selected_item, datatype)

    if datatype == "Name"
      puts "Current #{datatype}: #{selected_item.name}"
      puts "Enter New #{datatype}: "
      new_info = gets.chomp

      selected_item.name = new_info

    elsif datatype == "Brand"
      puts "Current #{datatype}: #{selected_item.brand}"
      puts "Enter New #{datatype}: "
      new_info = gets.chomp

      selected_item.brand = new_info

    elsif datatype == "Count"
      puts "Current #{datatype}: #{selected_item.count}"
      puts "Enter New #{datatype}: "
      new_info = gets.chomp

      selected_item.count = new_info

    elsif datatype == "Weight"
      puts "Current #{datatype}: #{selected_item.weight}"
      puts "Enter New #{datatype}: "
      new_info = gets.chomp

      selected_item.weight = new_info

    elsif datatype == "Produced By"
      puts "Current #{datatype}: #{selected_item.produced_by}"
      puts "Enter New #{datatype}: "
      new_info = gets.chomp

      selected_item.produced_by = new_info

    elsif datatype == "Produced In"
      puts "Current #{datatype}: #{selected_item.produced_in}"
      puts "Enter New #{datatype}: "
      new_info = gets.chomp

      selected_item.produced_in = new_info
    end

    selected_item.save

    self.success_interface("Successfully edited item!")
    self.main_menu

  end

  def edit_input_choice(selected_item, datatype)
    if datatype == "Tag"
      puts "Current Tag: #{selected_item.tag}"

      answer = self.prompt.select("Select the new tag") do |menu|
        menu.choice "Domestic", -> {self.tag_edit(selected_item, "Domestic")}
        menu.choice "International", -> {self.tag_edit(selected_item, "International")}
      end

    elsif datatype == "Category"
      puts "Current Category: #{selected_item.category}"

      answer = self.prompt.select("Select the new category") do |menu|
        menu.choice "Clothing", -> {self.category_edit(selected_item, "Clothing")}
        menu.choice "Food and Drinks", -> {self.category_edit(selected_item, "Food and Drinks")}
        menu.choice "Books", -> {self.category_edit(selected_item, "Books")}
        menu.choice "Entertainment", -> {self.category_edit(selected_item, "Entertainment")}
        menu.choice "Electronic Devices", -> {self.category_edit(selected_item, "Electronic Devices")}
        menu.choice "Health and Personal Care", -> {self.category_edit(selected_item, "Health and Personal Care")}
        menu.choice "Office Products", -> {self.category_edit(selected_item, "Office Products")}
        menu.choice "Sports", -> {self.category_edit(selected_item, "Sports")}
        menu.choice "Tools and Home Improvements", -> {self.category_edit(selected_item, "Tools and Home Improvements")}
        menu.choice "Fine Art", -> {self.category_edit(selected_item, "Fine Art")}
        menu.choice "Other", -> {self.category_edit(selected_item, "Other")}
      end

    end

  end

  def tag_edit(selected_item, new_tag)
    selected_item.tag = new_tag
    selected_item.save

    self.success_interface("Successfully edited item!")    
    self.main_menu
  end

  def category_edit(selected_item, new_category)
    selected_item.category = new_category
    selected_item.save

    self.success_interface("Successfully edited item!")
    self.main_menu
  end

  def filter_items
    
    brand = ""
    tag = ""
    category = ""
    produced_by = ""
    produced_in = ""

    condition = true

    while condition do

      answer = self.prompt.select("Set up filter") do |menu|
        menu.choice "Brand", -> {puts "Brand: #{brand = gets.chomp}"}
        menu.choice "Tag", -> {puts "Tag: #{tag = gets.chomp}"}
        menu.choice "Category", -> {puts "Tag: #{category = gets.chomp}"}
        menu.choice "Produced by", -> {puts "Produced By: #{produced_by = gets.chomp}"}
        menu.choice "Produced in", -> {puts "Produced In: #{produced_in = gets.chomp}"}
        menu.choice "FILTER", -> {self.filter(brand, tag, category, produced_by, produced_in)}
        menu.choice "Cancel", -> {self.main_menu}
      end

    end

  end

  def filter(brand, tag, category, produced_by, produced_in)
    filtered_items = Array.new

    brand_filtered_items = Array.new

    tag_filtered_items = Array.new

    category_filtered_items = Array.new

    produced_by_filtered_items = Array.new

    produced_in_filtered_items = Array.new

    if brand != ""
      brand_filtered_items = Item.all.select{
        |item| item.brand == brand
      }
      
      if (filtered_items != nil)
        filtered_items = brand_filtered_items
      else
        if brand_filtered_items != nil
          filtered_items = filtered_items & brand_filtered_items
        end
      end

    end

    if tag != ""
      tag_filtered_items = Item.all.select{
        |item| item.tag == tag
      }

      if (filtered_items != nil)
        filtered_items = tag_filtered_items
      else

        if tag_filtered_items != nil
          filtered_items = filtered_items & tag_filtered_items
        end

      end

    end

    if category != ""
      category_filtered_items = Item.all.select{
        |item| item.category == category
      }

      if (filtered_items != nil)
        filtered_items = category_filtered_items
      else

        if category_filtered_items != nil
          filtered_items = filtered_items & category_filtered_items
        end

      end

    end

    if produced_by != ""
      produced_by_filtered_items = Item.all.select{
        |item| item.produced_by == produced_by
      }

      if (filtered_items != nil)
        filtered_items = produced_by_filtered_items
      else

        if produced_by_filtered_items != nil
          filtered_items = filtered_items & produced_by_filtered_items
        end

      end

    end

    if produced_in != ""
      produced_in_filtered_items = Item.all.select{
        |item| item.produced_in == produced_in
      }

      if (filtered_items != nil)
        filtered_items = produced_in_filtered_items
      else

        if produced_in_filtered_items != nil
          filtered_items = filtered_items & produced_in_filtered_items
        end

      end

    end

    if filtered_items == nil
      puts "No results were found!"
      self.filter_items

    else
      puts "SIZE: #{filtered_items == nil}"
      table = TTY::Table.new(header: ["Name", "Brand", "Count", "Tag", "Category", "Weight", "Produced By", "Produced In"]) do |t|
        filtered_items.each{ |item|
            items_array = Array.new
  
            items_array << item.name
            items_array << item.brand
            items_array << item.count
            items_array << item.tag
            items_array << item.category
            items_array << item.weight
            items_array << item.produced_by
            items_array << item.produced_in
  
            t << items_array
        }
      end
      
      puts table.render(:ascii)
  
      self.main_menu
    end
  end

  def success_interface(sentence)
    success_box = TTY::Box.success(sentence)
    print success_box
  end


end
