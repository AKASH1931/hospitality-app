import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import 'role_select_screen.dart';

/// Legacy profile — kept for compat, now Luxero-framed. Primary route is AccountScreen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final role = app.role ?? 'brand';
    return Scaffold(
      appBar: AppBar(title: const Text('PROFILE')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: AppTheme.espresso, borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(children: [
              const CircleAvatar(radius: 30, backgroundColor: AppTheme.gold, child: Icon(Icons.person_rounded, color: Colors.white, size: 30)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(role == 'brand' ? 'Brand Account' : 'Staff Account', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                const Text('Demo · Backend soon', style: TextStyle(color: Colors.white70)),
              ])),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.champagne)),
            child: Column(children: [
              ListTile(leading: const Icon(Icons.work_history_rounded), title: Text('Total bookings: ${app.bookings.length}')),
              const Divider(height: 1),
              const ListTile(leading: Icon(Icons.support_agent_rounded), title: Text('Help and support')),
              const Divider(height: 1),
              const ListTile(leading: Icon(Icons.privacy_tip_rounded), title: Text('Privacy · Terms')),
            ]),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, seamlessRoute(const RoleSelectScreen()), (_) => false),
            child: const Text('Switch Role / Logout'),
          ),
        ],
      ),
    );
  }
}
