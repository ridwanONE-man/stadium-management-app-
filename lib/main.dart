import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:provider/provider.dart';
import 'loginpage.dart';
import 'homepage.dart';
import 'ticketpage.dart';
import 'matchschedulepage.dart';
import 'shoppage.dart';
import 'statuspage.dart';
import 'signuppage.dart';
import 'theme_provider.dart';
import 'settingspage.dart';
import 'admin_panel_page.dart';
import 'create_match_page.dart';
import 'UpdateMatchPage..dart'; // Fixed typo in file name
import 'match_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Theme management
        ChangeNotifierProvider(create: (_) => MatchProvider()), // Matches management
      ],
      child: const MyAppEntry(),
    ),
  );
}

class MyAppEntry extends StatelessWidget {
  const MyAppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/main': (context) => const MyApp(),
        '/signup': (context) => const SignupPage(),
        '/matchschedule': (context) => MatchSchedulePage(),
        '/settings': (context) => const SettingsPage(),
        '/admin_panel': (context) => const AdminPanelPage(),
        '/create_match': (context) => CreateMatchPage(
          teams: {}, // Placeholder; actual data comes from AdminPanelPage
        ),
      },
      home: const LoginPage(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const TicketPage(), // Ticket purchasing screen
    MatchSchedulePage(),
    const ShopPage(),
    const StatusPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
        currentIndex: currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat),
            label: 'Tickets', // The "Ticket" icon
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}
