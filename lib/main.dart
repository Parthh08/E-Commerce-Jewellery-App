import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/login_page.dart';
import 'controllers/cart_controller.dart';
import 'controllers/product_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(CartController());
    Get.put(ProductController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jewellery Shop',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFFD4AF37), // Gold
          secondary: Color(0xFF1A237E), // Deep Royal Blue
          surface: Color(0xFFFAF9F6), // Ivory
          background: Color(0xFFFFF8E1), // Light Cream
          error: Color(0xFFC62828), // Ruby Red
          onPrimary: Color(0xFFFAF9F6), // Ivory
          onSecondary: Color(0xFFFAF9F6), // Ivory
          onSurface: Color(0xFF212121), // Dark Charcoal
          onBackground: Color(0xFF212121), // Dark Charcoal
          onError: Color(0xFFFAF9F6), // Ivory
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF212121)),
          bodyMedium: TextStyle(color: Color(0xFF757575)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37),
            foregroundColor: const Color(0xFFFAF9F6),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1A237E),
            side: const BorderSide(color: Color(0xFF1A237E)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD4AF37),
          foregroundColor: Color(0xFFFAF9F6),
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFFFAF9F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
      ),
      home: LoginPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomePage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: const Color(0xFFD4AF37),
        indicatorColor: Colors.white.withOpacity(0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Color(0xFFFAF9F6)),
            selectedIcon: Icon(Icons.home, color: Color(0xFFFAF9F6)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Color(0xFFFAF9F6)),
            selectedIcon: Icon(Icons.person, color: Color(0xFFFAF9F6)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
