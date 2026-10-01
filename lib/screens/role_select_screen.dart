import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import 'home_shell.dart';

/// Entry — Luxero-framed: espresso hero, Bodoni headline, gold kicker, no emojis.
class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppTheme.espresso, Color(0xFF4A3521), AppTheme.bg],
            stops: [0.0, 0.55, 0.551],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('TRUSTED BY 500+ VENUES',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: AppTheme.lightGold, fontSize: 11,
                          letterSpacing: 1.4, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 20),
                Text('ELEVATING EXPERIENCES. DELIVERING EXCELLENCE.',
                    style: GoogleFonts.bodoniModa(
                        color: Colors.white, fontSize: 30, height: 0.95, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Text('Chefs · Waiters · Bartenders · Decor · Events · Services',
                    style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.75), fontSize: 14, height: 1.5)),
                const Spacer(),
                _RoleCard(
                  icon: Icons.storefront_rounded,
                  title: 'I’m a Brand',
                  subtitle: 'Post event, hire verified staff',
                  onTap: () => _go(context, 'brand'),
                  primary: true,
                ),
                const SizedBox(height: 12),
                _RoleCard(
                  icon: Icons.badge_rounded,
                  title: 'I’m Staff / Vendor',
                  subtitle: 'Get gigs, grow earnings',
                  onTap: () => _go(context, 'worker'),
                  primary: false,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _go(BuildContext context, String role) {
    context.read<AppState>().setRole(role);
    Navigator.pushReplacement(context, seamlessRoute(const HomeShell()));
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool primary;
  final VoidCallback onTap;
  const _RoleCard({required this.icon, required this.title, required this.subtitle, required this.primary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primary ? Colors.white : Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: primary ? null : Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  color: primary ? AppTheme.midnight : AppTheme.gold.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: primary ? Colors.white : AppTheme.midnight),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                ]),
              ),
              const Icon(Icons.arrow_forward_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
