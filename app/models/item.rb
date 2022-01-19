class Item < ActiveRecord::Base

    def self.total_count
        total = 0
        Item.all.each{
            |item| total = total + item.count
        }

        return total
    end

    def self.tag_total_number(tag)
        items = Item.all.select{
            |item| item.tag == tag
        }

        return items.count
    end

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
