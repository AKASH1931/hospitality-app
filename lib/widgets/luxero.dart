import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/content.dart';

/// Shared Luxero widgets: section headers (Bodoni UPPERCASE), gold CTA rule,
/// contact strip. No emojis anywhere.

class SectionHeader extends StatelessWidget {
  final String kicker;
  final String title;
  final String? subtitle;
  const SectionHeader({super.key, required this.kicker, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(kicker.toUpperCase(),
          style: GoogleFonts.inter(
              fontSize: 11, fontWeight: FontWeight.w700,
              letterSpacing: 1.4, color: AppTheme.gold)),
      const SizedBox(height: 6),
      Text(title.toUpperCase(),
          style: GoogleFonts.bodoniModa(
              fontSize: 24, fontWeight: FontWeight.w600,
              color: AppTheme.ink, height: 0.95)),
      if (subtitle != null) ...[
        const SizedBox(height: 6),
        Text(subtitle!,
            style: GoogleFonts.inter(
                fontSize: 15, height: 1.55, color: AppTheme.ink.withOpacity(0.72))),
      ],
    ]);
  }
}

class LuxeroHero extends StatelessWidget {
  final VoidCallback onEnquire;
  final VoidCallback onHireTap;
  const LuxeroHero({super.key, required this.onEnquire, required this.onHireTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.espresso,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Giant LUXERO backdrop
        Text('LUXERO',
            style: GoogleFonts.bodoniModa(
                fontSize: 52, fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.08), height: 0.9, letterSpacing: 2)),
        const SizedBox(height: 8),
        Text('GOLD-STANDARD HOSPITALITY',
            style: GoogleFonts.inter(
                fontSize: 11, fontWeight: FontWeight.w700,
                letterSpacing: 1.6, color: AppTheme.lightGold)),
        const SizedBox(height: 10),
        Text('ELEVATING EXPERIENCES.\nDELIVERING EXCELLENCE.',
            style: GoogleFonts.bodoniModa(
                fontSize: 26, fontWeight: FontWeight.w600,
                color: Colors.white, height: 0.95)),
        const SizedBox(height: 10),
        Text(
          'Luxero Hospitality Solutions, Lucknow — operations, F&B, artists, catering, vendors and training. Direct hire for chefs, waiters, bartenders, housekeeping and decor.',
          style: GoogleFonts.inter(fontSize: 14, height: 1.55, color: Colors.white70),
        ),
        const SizedBox(height: 16),
        // Single gold primary CTA per screen (handoff rule)
        ElevatedButton(onPressed: onEnquire, child: const Text('Enquire Now')),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: onHireTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: AppTheme.lightGold),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Hire Staff'),
        ),
        const SizedBox(height: 12),
        Text('WhatsApp $contactPhone · $contactEmail',
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white60)),
      ]),
    );
  }
}

class ContactStrip extends StatelessWidget {
  const ContactStrip({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.champagne),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('TALK TO LUXERO',
            style: GoogleFonts.inter(
                fontSize: 11, fontWeight: FontWeight.w700,
                letterSpacing: 1.4, color: AppTheme.gold)),
        const SizedBox(height: 8),
        _row(Icons.call_rounded, contactPhone),
        _row(Icons.mail_rounded, contactEmail),
        _row(Icons.chat_rounded, 'WhatsApp: $contactPhone'),
        _row(Icons.camera_alt_rounded, 'Instagram: luxerohospitality'),
      ]),
    );
  }

  Widget _row(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, size: 18, color: AppTheme.ink),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600))),
      ]),
    );
  }
}
