import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'services_screen.dart';
import 'events_screen.dart';
import 'contact_screen.dart';
import 'account_screen.dart';

/// Mix scope: Hire + Services + Events + Contact + Account.
/// Hire keeps the direct-hire marketplace; Services/Events/Contact mirror
/// the Luxero website (APP-HANDOFF.md); Account holds bookings + profile.
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
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Hire'),
          NavigationDestination(icon: Icon(Icons.concierge_rounded), label: 'Services'),
          NavigationDestination(icon: Icon(Icons.celebration_rounded), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.mail_rounded), label: 'Contact'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Account'),
        ],
      ),
    );
  }

  Widget _page(int i) {
    switch (i) {
      case 1:
        return const ServicesScreen(key: ValueKey('services'));
      case 2:
        return const EventsScreen(key: ValueKey('events'));
      case 3:
        return const ContactScreen(key: ValueKey('contact'));
      case 4:
        return const AccountScreen(key: ValueKey('account'));
      default:
        return HomeScreen(key: const ValueKey('hire'), onSearchTap: () => _go(0));
    }
  }
}

// Kept for deep-links that still push Search directly.
class SearchEntry extends StatelessWidget {
  const SearchEntry({super.key});
  @override
  Widget build(BuildContext context) => const SearchScreen();
}
