class Item < ActiveRecord::Base

    # A class method to return the total count of items in the inventory
    def self.total_count
        total = 0
        Item.all.each{
            |item| total = total + item.count
        }

        return total
    end

    # A class method to return the total number of items in the inventory with a specific tag
    def self.tag_total_number(tag)
        items = Item.all.select{
            |item| item.tag == tag
        }

        return items.count
    end

    # A class method to return the total count of items in the inventory with a specific tag
    def self.tag_total_count(tag)
        total = 0

        items = Item.all.select{
            |item| item.tag == tag
        }

        items.each{
            |item| total = total + item.count
        }

        return total
    end

    # A class method to return the total count of items in the inventory with a specific category
    def self.category_count(category)
        total = 0
        items = Item.all.select{
            |item| item.category == category
        }

        items.each{
            |item| total = total + item.count
        }

        return total
    end

    # A class method to return the total count of items in the inventory with a specific place of production
    def self.produced_in_count(country)
        total = 0
        items = Item.all.select{
            |item| item.produced_in == country
        }

        items.each{
            |item| total = total + item.count
        }

        return total
    end
end
