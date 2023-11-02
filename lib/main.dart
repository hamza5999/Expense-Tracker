import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

// Its a convention to start the global variable names with "k", especially the
// variables representing color schemes

var kColorScheme = ColorScheme.fromSeed(
  // fromSeed() is used to set the base color. Different variants of it will be
  // used later

  seedColor: const Color.fromARGB(255, 96, 59, 181),
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
      home: const Expenses(),
    ),
  );
}
