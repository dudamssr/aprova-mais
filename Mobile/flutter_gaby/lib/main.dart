import 'package:flutter/material.dart';
import 'ui/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkTheme = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aprova+',
      theme: darkTheme
          ? ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF0D1B2A),
              cardColor: const Color(0xFF1B263B),
              primaryColor: const Color(0xFF1565C0),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF1976D2),
                secondary: Color(0xFF42A5F5),
                surface: Color(0xFF1B263B),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF0D47A1),
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
                titleLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Color(0xFF1B263B),
                hintStyle: TextStyle(color: Colors.white54),
                labelStyle: TextStyle(color: Colors.white),
                floatingLabelStyle: TextStyle(color: Color(0xFF42A5F5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xFF42A5F5),
                selectionColor: Color(0xFF1565C0),
                selectionHandleColor: Color(0xFF42A5F5),
              ),
            )
          : ThemeData(
              brightness: Brightness.light,
              // fundo atualizado para #c6cdd8
              scaffoldBackgroundColor: const Color(0xFFC6CDD8),

              primaryColor: const Color(0xFF1565C0),

              colorScheme: const ColorScheme.light(
                primary: Color(0xFF1565C0),
                secondary: Color(0xFF42A5F5),
                surface: Colors.white,
              ),

              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1565C0),
                foregroundColor: Colors.white,
              ),

              cardColor: Colors.white,

              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Color(0xFF263238), fontSize: 16),
                titleLarge: TextStyle(
                  color: Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(color: Colors.black45),
                labelStyle: TextStyle(color: Color(0xFF263238)),
                floatingLabelStyle: TextStyle(color: Color(0xFF1565C0)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF90CAF9)),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),

              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xFF1565C0),
                selectionColor: Color(0xFF90CAF9),
                selectionHandleColor: Color(0xFF1565C0),
              ),
            ),
      home: const SplashScreen(),
    );
  }
}
