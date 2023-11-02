# Expense Tracker App

It is an expense tracker app where users can effortlessly record and manage expenses and view their expenses. Additionally, users can gain insights into their spending patterns through an interactive chart display.

## Widgets learned:

- ListView
- Card
- Padding
- Spacer
- AppBar
- IconButton
- Builtin Flutter UI Elements - showModalBottomSheet, showDatePicker, showDialog etc
- TextField
- TextEditingController() class
- Navigator class
- Future data type
- DropDownButton
- AlertDialog
- Dismissible
- ScaffoldMessenger utility object
- ThemeData().copyWith(), AppBarTheme().copyWith() and CardTheme().copyWith() etc
- ColorScheme.fromSeed()

## Things learned:

- Used Uuid external package to generate unique id
- Defined and used Enum
- Difference between using simple ListView with its children property and ListView with builder constructor i.e ListView.builder()
- Used Card widget to display list items
- Used padding widget to add padding around widgets
- Used spacer widget to add space between multiple widgets
- Formatted date using an external package named intl
- Used appBar property of Scaffold widget to create an app bar
- Made a button that only contains an icon using the IconButton
- Used theme property of Scaffold to add Material3 (default is Material2) app bar using ThemeData widget
- Used flutter builtin UI elements like the one named showModalBottomSheet to show a modal
- Used TextField widget to add an input field
- Used decoration property of TextField with InputDecoration to add labels to the fields
- Used TextEditingController class to store and handle the user input
- Used dispose() to delete TextEditingController() after use
- Add $ sign by default in the amount field using the prefix paramter of InputDecoration
- Used Naviagtor class's pop method to switch back from the modal
- Made a custom date field
- Used a builtin date picker UI element
- Used async and await to handle the response wrapped in a future after using showDatePicker
- Used null check to force dart that a certain value won't be null
- Made a dropdown menu button using the builtin UI element named DropDownButton
- Add validations on these fields
- Displayed error messages using the builtin UI element named showDialog and a widget named AlertDialog
- Remove list item by swipping it using the Dismissible widget
- Generated a unique key using the ValueKey()
- Remove the expense item from the Expense list using remove() and pass the function in the onDismissed parameter of the Dismissible widget
- Used ScaffoldMessenger utility object to show info messages for certain actions
- Added undo functionality using indexOf() and insert()
- Used different themeing constructors with copyWith() to copy the default theme styles and customize selected ones
- Used ColorScheme.fromSeed() to set the base color
- Theme.of() to use the theme styles in widgets
