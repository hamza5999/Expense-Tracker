import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

// Its a convention to start the global variable names with "k", especially the
// variables representing color schemes

var kColorScheme = ColorScheme.fromSeed(
  // fromSeed() is used to set the base color. Different variants of it will be
  // generated automatically and can be used later

  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  // fromSeed() is used to set the base color. Different variants of it will be
  // generated automatically and can be used later

  seedColor: const Color.fromARGB(255, 5, 99, 125),
  // Have to add brightness to tell flutter to optimize the color shades and
  // and variants for the dark theme

  brightness: Brightness.dark,
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          centerTitle: false,
          // Referencing the base color "kColorScheme" to use different
          // variants of it

          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              // Using it like this "textTheme: ThemeData().textTheme.copyWith()"
              // instead of "TextTheme" so that we may use the default styles

              // Approach 1
              // bodyLarge: ThemeData().textTheme.bodyLarge!.copyWith(
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     )

              // Approach 2
              bodyLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),

        // Using copyWith() to apply some default stylings and to customize
        // the theme and to override some selective styles else it we have to use
        // all style properties

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        // There is no copyWith() for the elevated button theme that's why using
        // the styleFrom()
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
          ),
        ),
      ),
      // themeMode: ThemeMode.system, // default
      home: const Expenses(),
    ),
  );
}
