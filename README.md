# Shopify Backend Challenge (Inventory App)

### Developed By: [Daniel Mekuriaw](https://github.com/danielmekuriaw)

## Description

**TASK:** Build an inventory tracking web application for a logistics company. We are looking for a web application that meets the requirements listed below, along with one additional feature, with the options also listed below. 

## Requirements

**Basic CRUD Functionality.** You should be able to:
- Create inventory items
- Edit Them
- Delete Them
- View a list of them

**ONE OF THE OPTIONAL FEATURES (I chose the following):**
- Filtering based on fields/inventory count/tags/other metadata

## Inventory App

This CLI (Command-line interface) application is a simple interactive application that allows users to create and manage an inventory of the different items they may have. It allows users to add, edit, delete, view and filter the items in the inventory.

This project is developed using **Ruby**, **ActiveRecord** and **SQLite3**. For the sake of simplicity and due to the limited amount of time for development, it makes use of data from the **Faker** Ruby gem to seed some data in the database, outside of accepting direct user inputs.

### Gems

* **sinatra-activerecord** - for accessing databases
* **sqlite3** - for database management
* **pry** - for debugging during development
* **require_all** - for accessing files from within different directories of the program
* **faker** - for generating random data
* **tty-prompt** - for accepting user inputs in different formats
* **tty-table** - for displaying data in a table
* **tty-box** - for displaying data in a box
* **tty-font** - for creating the **INVENTORY APP** logo that appears at the start of the program

### Setup Instructions

**NOTE:** *Make sure you have properly installed Ruby on your terminal. Follow the instructions below after verifying that you have correctly installed ruby through the following command. It should return a Ruby version if you have Ruby installed. If you do not have Ruby installed, follow the instructions, download and install the version compatible with your device from [here](https://www.ruby-lang.org/en/downloads/)*

```Ruby
ruby --version
```

The next step is installing the required gems. Once you are inside the directory of this project, this can be done with the following command:
```Ruby 
bundle install
```

In case you run onto an error while calling the command above, try installing each gem individually as follows:
```Ruby
gem install name_of_gem
```

### Running the Program
To run the program, call the following while you are still in the project's directory on your terminal:

```Ruby
ruby ./bin/run.rb
```

### Using Inventory App
When using the Inventory App, you can use your arrow keys to move the up and down for multiple choice prompts. For some direct inputs, you are asked to input the respective information (i.e. in cases of adding information about a new entry or editing the information of an existing entry).


# NEXT TASK
- CLEAN UP CODE
- CLEAN UP THE INTERFACES [ADD SUCCESS STUFF]
- Add some more cleaner instructions
- Add FILE STRUCTURE
- Test it out and include a gif demo
- MENTION RUNNING IT ON AN INDEPENDENT TERMINAL MAY BE BETTER THAN JUST RUNNING IT ON AN INTEGRATED TERMINAL LIKE ON VS CODE FOR BETTER VISUALS AND TABLE DISPLAY