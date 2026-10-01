import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../widgets/luxero.dart';
import 'role_select_screen.dart';
import 'pricing_screen.dart';
import 'bookings_screen.dart';

/// Account — bookings summary + profile + Luxero More (Pricing / Expertise / About).
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final role = app.role ?? 'brand';
    return Scaffold(
      appBar: AppBar(title: const Text('ACCOUNT')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.espresso,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(children: [
              const CircleAvatar(
                  radius: 30, backgroundColor: AppTheme.gold,
                  child: Icon(Icons.person_rounded, color: Colors.white, size: 30)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(role == 'brand' ? 'BRAND ACCOUNT' : 'STAFF ACCOUNT',
                    style: GoogleFonts.bodoniModa(
                        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                Text('Demo — backend soon · ${app.bookings.length} booking(s)',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
              ])),
            ]),
          ),
          const SizedBox(height: 14),
          _tile(context, Icons.calendar_month_rounded, 'My bookings',
              '${app.bookings.length} total — tap to view',
              () => Navigator.push(context, seamlessRoute(const BookingsScreen()))),
          _tile(context, Icons.payments_rounded, 'Pricing and combo',
              'Rs 20,000 / head · Rs 50,000 any 4',
              () => Navigator.push(context, seamlessRoute(const PricingScreen()))),
          _tile(context, Icons.school_rounded, 'Expertise',
              'Pre-opening in 6 steps · F&B framework · checklists',
              () => _expertiseSheet(context)),
          _tile(context, Icons.business_rounded, 'About Luxero',
              'Satyam Tandon · Taj-trained · Lucknow',
              () => _aboutSheet(context)),
          _tile(context, Icons.support_agent_rounded, 'Help and support',
              contactPhoneLabel(), null),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, seamlessRoute(const RoleSelectScreen()), (_) => false),
            child: const Text('Switch Role / Logout'),
          ),
          const SizedBox(height: 14),
          const ContactStrip(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String contactPhoneLabel() => '+919305608569 · info@luxerohospitalitysolutions.com';

  Widget _tile(BuildContext context, IconData icon, String title, String sub, VoidCallback? onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.champagne),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.ink),
        title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15)),
        subtitle: Text(sub, style: GoogleFonts.inter(fontSize: 13)),
        trailing: onTap == null ? null : const Icon(Icons.arrow_forward_rounded, size: 20),
        onTap: onTap,
      ),
    );
  }

  void _expertiseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(22),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('EXPERTISE', style: GoogleFonts.bodoniModa(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Pre-opening in 6 steps: Discover, Diagnose, Design, Deliver, Drive, plus handover. F&B framework covers menu, kitchen systems, service and costing.',
              style: GoogleFonts.inter(fontSize: 14, height: 1.6)),
          const SizedBox(height: 8),
          Text('People checklist: grooming, etiquette, SOP drills and vendor coordination.',
              style: GoogleFonts.inter(fontSize: 14, height: 1.6)),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }

  void _aboutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(22),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ABOUT LUXERO', style: GoogleFonts.bodoniModa(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Owner Satyam Tandon — 13 years from Vivanta Taj (2012) to Luxero (Dec 2025). Taj Christmas and New Year specialist, based in Lucknow.',
              style: GoogleFonts.inter(fontSize: 14, height: 1.6)),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}
