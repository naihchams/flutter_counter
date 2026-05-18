import 'package:counter_ui_practice/screens/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoaded = false;
  bool _darkMode = false;
  Color _themeColor = const Color.fromRGBO(117, 93, 236, 1);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      final colorValue = prefs.getInt('themeColor');
      if (colorValue != null) {
        _themeColor = Color(colorValue);
      }
      _isLoaded = true;
    });
  }

  Future<void> _refreshTheme() async {
    await _loadSettings();
  }

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _themeColor,
      brightness: brightness,
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      useMaterial3: true,
      primaryColor: _themeColor,
      scaffoldBackgroundColor: brightness == Brightness.light
          ? const Color.fromRGBO(248, 246, 253, 1)
          : const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: _themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      cardColor: brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF1E1E1E),
      canvasColor: brightness == Brightness.light
          ? const Color(0xFFF6F4FD)
          : const Color(0xFF121212),
      dialogTheme: DialogThemeData(
        backgroundColor: brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF1E1E1E),
      ),
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
        bodyColor: brightness == Brightness.light
            ? Colors.black87
            : Colors.white70,
      ),
      iconTheme: IconThemeData(
        color: brightness == Brightness.light ? Colors.black54 : Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: CounterScreen(onSettingsChanged: _refreshTheme),
    );
  }
}
