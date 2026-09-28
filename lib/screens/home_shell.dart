import 'package:flutter/material.dart';
import '../main.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'bookings_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int idx = 0;

  void _go(int i) => setState(() => idx = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _page(idx),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: _go,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.calendar_month_rounded), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _page(int i) {
    switch (i) {
      case 1:
        return const SearchScreen(key: ValueKey('search'));
      case 2:
        return const BookingsScreen(key: ValueKey('bookings'));
      case 3:
        return const ProfileScreen(key: ValueKey('profile'));
      default:
        return HomeScreen(key: const ValueKey('home'), onSearchTap: () => _go(1));
    }
  }
}
