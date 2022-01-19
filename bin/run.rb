# Requiring what is specified in the environment file
require_relative '../config/environment'

# Initializing an application instance using the InventoryApp class (i.e. creating an InventoryApp object)
app = InventoryApp.new

# Displaying the application logo and a small description
app.greeting

# Displaying the main menu with different options
app.main_menu


